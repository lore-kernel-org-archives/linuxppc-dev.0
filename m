Return-Path: <slightlyunconventional@gmail.com>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.212.179]) by ozlabs.org (Postfix) with ESMTP id B43121007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  3 Jul 2010 03:59:41 +1000 (EST)
Received: by pxi7 with SMTP id 7so1463329pxi.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 02 Jul 2010 10:59:39 -0700 (PDT)
MIME-Version: 1.0
Sender: slightlyunconventional@gmail.com
In-Reply-To: <1277980982-12433-28-git-send-email-agraf@suse.de>
References: <1277980982-12433-1-git-send-email-agraf@suse.de>
	<1277980982-12433-28-git-send-email-agraf@suse.de>
Date: Fri, 2 Jul 2010 10:59:39 -0700
Message-ID: <AANLkTiksUkrO8ryEiX3Yv-_2KGVE6r5RIT4YDvrmoDPL@mail.gmail.com>
Subject: Re: [PATCH 27/27] KVM: PPC: Add Documentation about PV interface
From: Hollis Blanchard <hollis@penguinppc.org>
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Resending...]

Please reconcile this with
http://www.linux-kvm.org/page/PowerPC_Hypercall_ABI, which has been
discussed in the (admittedly closed) Power.org embedded hypervisor
working group. Bear in mind that other hypervisors are already
implementing the documented ABI, so if you have concerns, you should
probably raise them with that audience...

-Hollis

On Thu, Jul 1, 2010 at 3:43 AM, Alexander Graf <agraf@suse.de> wrote:
>
> We just introduced a new PV interface that screams for documentation. So =
here
> it is - a shiny new and awesome text file describing the internal works o=
f
> the PPC KVM paravirtual interface.
>
> Signed-off-by: Alexander Graf <agraf@suse.de>
>
> ---
>
> v1 -> v2:
>
> =A0- clarify guest implementation
> =A0- clarify that privileged instructions still work
> =A0- explain safe MSR bits
> =A0- Fix dsisr patch description
> =A0- change hypervisor calls to use new register values
> ---
> =A0Documentation/kvm/ppc-pv.txt | =A0185 ++++++++++++++++++++++++++++++++=
++++++++++
> =A01 files changed, 185 insertions(+), 0 deletions(-)
> =A0create mode 100644 Documentation/kvm/ppc-pv.txt
>
> diff --git a/Documentation/kvm/ppc-pv.txt b/Documentation/kvm/ppc-pv.txt
> new file mode 100644
> index 0000000..82de6c6
> --- /dev/null
> +++ b/Documentation/kvm/ppc-pv.txt
> @@ -0,0 +1,185 @@
> +The PPC KVM paravirtual interface
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The basic execution principle by which KVM on PowerPC works is to run al=
l kernel
> +space code in PR=3D1 which is user space. This way we trap all privilege=
d
> +instructions and can emulate them accordingly.
> +
> +Unfortunately that is also the downfall. There are quite some privileged
> +instructions that needlessly return us to the hypervisor even though the=
y
> +could be handled differently.
> +
> +This is what the PPC PV interface helps with. It takes privileged instru=
ctions
> +and transforms them into unprivileged ones with some help from the hyper=
visor.
> +This cuts down virtualization costs by about 50% on some of my benchmark=
s.
> +
> +The code for that interface can be found in arch/powerpc/kernel/kvm*
> +
> +Querying for existence
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To find out if we're running on KVM or not, we overlay the PVR register.=
 Usually
> +the PVR register contains an id that identifies your CPU type. If, howev=
er, you
> +pass KVM_PVR_PARA in the register that you want the PVR result in, the r=
egister
> +still contains KVM_PVR_PARA after the mfpvr call.
> +
> + =A0 =A0 =A0 LOAD_REG_IMM(r5, KVM_PVR_PARA)
> + =A0 =A0 =A0 mfpvr =A0 r5
> + =A0 =A0 =A0 [r5 still contains KVM_PVR_PARA]
> +
> +Once determined to run under a PV capable KVM, you can now use hypercall=
s as
> +described below.
> +
> +PPC hypercalls
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The only viable ways to reliably get from guest context to host context =
are:
> +
> + =A0 =A0 =A0 1) Call an invalid instruction
> + =A0 =A0 =A0 2) Call the "sc" instruction with a parameter to "sc"
> + =A0 =A0 =A0 3) Call the "sc" instruction with parameters in GPRs
> +
> +Method 1 is always a bad idea. Invalid instructions can be replaced late=
r on
> +by valid instructions, rendering the interface broken.
> +
> +Method 2 also has downfalls. If the parameter to "sc" is !=3D 0 the spec=
 is
> +rather unclear if the sc is targeted directly for the hypervisor or the
> +supervisor. It would also require that we read the syscall issuing instr=
uction
> +every time a syscall is issued, slowing down guest syscalls.
> +
> +Method 3 is what KVM uses. We pass magic constants (KVM_SC_MAGIC_R0 and
> +KVM_SC_MAGIC_R3) in r0 and r3 respectively. If a syscall instruction wit=
h these
> +magic values arrives from the guest's kernel mode, we take the syscall a=
s a
> +hypercall.
> +
> +The parameters are as follows:
> +
> + =A0 =A0 =A0 r0 =A0 =A0 =A0 =A0 =A0 =A0 =A0KVM_SC_MAGIC_R0
> + =A0 =A0 =A0 r3 =A0 =A0 =A0 =A0 =A0 =A0 =A0KVM_SC_MAGIC_R3 =A0 =A0 =A0 =
=A0 Return code
> + =A0 =A0 =A0 r4 =A0 =A0 =A0 =A0 =A0 =A0 =A0Hypercall number
> + =A0 =A0 =A0 r5 =A0 =A0 =A0 =A0 =A0 =A0 =A0First parameter
> + =A0 =A0 =A0 r6 =A0 =A0 =A0 =A0 =A0 =A0 =A0Second parameter
> + =A0 =A0 =A0 r7 =A0 =A0 =A0 =A0 =A0 =A0 =A0Third parameter
> + =A0 =A0 =A0 r8 =A0 =A0 =A0 =A0 =A0 =A0 =A0Fourth parameter
> +
> +Hypercall definitions are shared in generic code, so the same hypercall =
numbers
> +apply for x86 and powerpc alike.
> +
> +The magic page
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To enable communication between the hypervisor and guest there is a new =
shared
> +page that contains parts of supervisor visible register state. The guest=
 can
> +map this shared page using the KVM hypercall KVM_HC_PPC_MAP_MAGIC_PAGE.
> +
> +With this hypercall issued the guest always gets the magic page mapped a=
t the
> +desired location in effective and physical address space. For now, we al=
ways
> +map the page to -4096. This way we can access it using absolute load and=
 store
> +functions. The following instruction reads the first field of the magic =
page:
> +
> + =A0 =A0 =A0 ld =A0 =A0 =A0rX, -4096(0)
> +
> +The interface is designed to be extensible should there be need later to=
 add
> +additional registers to the magic page. If you add fields to the magic p=
age,
> +also define a new hypercall feature to indicate that the host can give y=
ou more
> +registers. Only if the host supports the additional features, make use o=
f them.
> +
> +The magic page has the following layout as described in
> +arch/powerpc/include/asm/kvm_para.h:
> +
> +struct kvm_vcpu_arch_shared {
> + =A0 =A0 =A0 __u64 scratch1;
> + =A0 =A0 =A0 __u64 scratch2;
> + =A0 =A0 =A0 __u64 scratch3;
> + =A0 =A0 =A0 __u64 critical; =A0 =A0 =A0 =A0 /* Guest may not get interr=
upts if =3D=3D r1 */
> + =A0 =A0 =A0 __u64 sprg0;
> + =A0 =A0 =A0 __u64 sprg1;
> + =A0 =A0 =A0 __u64 sprg2;
> + =A0 =A0 =A0 __u64 sprg3;
> + =A0 =A0 =A0 __u64 srr0;
> + =A0 =A0 =A0 __u64 srr1;
> + =A0 =A0 =A0 __u64 dar;
> + =A0 =A0 =A0 __u64 msr;
> + =A0 =A0 =A0 __u32 dsisr;
> + =A0 =A0 =A0 __u32 int_pending; =A0 =A0 =A0/* Tells the guest if we have=
 an interrupt */
> +};
> +
> +Additions to the page must only occur at the end. Struct fields are alwa=
ys 32
> +bit aligned.
> +
> +MSR bits
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The MSR contains bits that require hypervisor intervention and bits that=
 do
> +not require direct hypervisor intervention because they only get interpr=
eted
> +when entering the guest or don't have any impact on the hypervisor's beh=
avior.
> +
> +The following bits are safe to be set inside the guest:
> +
> + =A0MSR_EE
> + =A0MSR_RI
> + =A0MSR_CR
> + =A0MSR_ME
> +
> +If any other bit changes in the MSR, please still use mtmsr(d).
> +
> +Patched instructions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The "ld" and "std" instructions are transormed to "lwz" and "stw" instru=
ctions
> +respectively on 32 bit systems with an added offset of 4 to accomodate f=
or big
> +endianness.
> +
> +The following is a list of mapping the Linux kernel performs when runnin=
g as
> +guest. Implementing any of those mappings is optional, as the instructio=
n traps
> +also act on the shared page. So calling privileged instructions still wo=
rks as
> +before.
> +
> +From =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 To
> +=3D=3D=3D=3D =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D
> +
> +mfmsr =A0rX =A0 =A0 =A0 =A0 =A0 =A0 =A0ld =A0 =A0 =A0rX, magic_page->msr
> +mfsprg rX, 0 =A0 =A0 =A0 =A0 =A0 ld =A0 =A0 =A0rX, magic_page->sprg0
> +mfsprg rX, 1 =A0 =A0 =A0 =A0 =A0 ld =A0 =A0 =A0rX, magic_page->sprg1
> +mfsprg rX, 2 =A0 =A0 =A0 =A0 =A0 ld =A0 =A0 =A0rX, magic_page->sprg2
> +mfsprg rX, 3 =A0 =A0 =A0 =A0 =A0 ld =A0 =A0 =A0rX, magic_page->sprg3
> +mfsrr0 rX =A0 =A0 =A0 =A0 =A0 =A0 =A0ld =A0 =A0 =A0rX, magic_page->srr0
> +mfsrr1 rX =A0 =A0 =A0 =A0 =A0 =A0 =A0ld =A0 =A0 =A0rX, magic_page->srr1
> +mfdar =A0rX =A0 =A0 =A0 =A0 =A0 =A0 =A0ld =A0 =A0 =A0rX, magic_page->dar
> +mfdsisr =A0 =A0 =A0 =A0rX =A0 =A0 =A0 =A0 =A0 =A0 =A0lwz =A0 =A0 rX, mag=
ic_page->dsisr
> +
> +mtmsr =A0rX =A0 =A0 =A0 =A0 =A0 =A0 =A0std =A0 =A0 rX, magic_page->msr
> +mtsprg 0, rX =A0 =A0 =A0 =A0 =A0 std =A0 =A0 rX, magic_page->sprg0
> +mtsprg 1, rX =A0 =A0 =A0 =A0 =A0 std =A0 =A0 rX, magic_page->sprg1
> +mtsprg 2, rX =A0 =A0 =A0 =A0 =A0 std =A0 =A0 rX, magic_page->sprg2
> +mtsprg 3, rX =A0 =A0 =A0 =A0 =A0 std =A0 =A0 rX, magic_page->sprg3
> +mtsrr0 rX =A0 =A0 =A0 =A0 =A0 =A0 =A0std =A0 =A0 rX, magic_page->srr0
> +mtsrr1 rX =A0 =A0 =A0 =A0 =A0 =A0 =A0std =A0 =A0 rX, magic_page->srr1
> +mtdar =A0rX =A0 =A0 =A0 =A0 =A0 =A0 =A0std =A0 =A0 rX, magic_page->dar
> +mtdsisr =A0 =A0 =A0 =A0rX =A0 =A0 =A0 =A0 =A0 =A0 =A0stw =A0 =A0 rX, mag=
ic_page->dsisr
> +
> +tlbsync =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0nop
> +
> +mtmsrd rX, 0 =A0 =A0 =A0 =A0 =A0 b =A0 =A0 =A0 <special mtmsr section>
> +mtmsr =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0b =A0 =A0 =A0 <special mtmsr se=
ction>
> +
> +mtmsrd rX, 1 =A0 =A0 =A0 =A0 =A0 b =A0 =A0 =A0 <special mtmsrd section>
> +
> +[BookE only]
> +wrteei [0|1] =A0 =A0 =A0 =A0 =A0 b =A0 =A0 =A0 <special wrteei section>
> +
> +
> +Some instructions require more logic to determine what's going on than a=
 load
> +or store instruction can deliver. To enable patching of those, we keep s=
ome
> +RAM around where we can live translate instructions to. What happens is =
the
> +following:
> +
> + =A0 =A0 =A0 1) copy emulation code to memory
> + =A0 =A0 =A0 2) patch that code to fit the emulated instruction
> + =A0 =A0 =A0 3) patch that code to return to the original pc + 4
> + =A0 =A0 =A0 4) patch the original instruction to branch to the new code
> +
> +That way we can inject an arbitrary amount of code as replacement for a =
single
> +instruction. This allows us to check for pending interrupts when setting=
 EE=3D1
> +for example.
> +
> --
> 1.6.0.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
