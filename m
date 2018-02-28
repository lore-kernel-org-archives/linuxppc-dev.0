Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zryrp0N0zzF1ZD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 01:39:51 +1100 (AEDT)
Subject: Re: Build regressions/improvements in v4.16-rc3
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@ozlabs.org>
References: <1519817278-30770-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVEFXL6hXhBNya-9LjORrZnyJJPzoBNMrufAdPEBVhLtA@mail.gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <51783a88-f15e-f604-8439-1711282e4462@xenosoft.de>
Date: Wed, 28 Feb 2018 15:39:41 +0100
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVEFXL6hXhBNya-9LjORrZnyJJPzoBNMrufAdPEBVhLtA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geert,

The following patch should be in the commit 'kvm-ppc-next-4.16-2' [1]:

Fixes: accb757d798c ("KVM: Move vcpu_load to arch-specific 
kvm_arch_vcpu_ioctl_run")
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
arch/powerpc/kvm/powerpc.c | 2 ++
1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 403e642c78f5..0083142c2f84 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1608,7 +1608,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, 
struct kvm_run *run)

kvm_sigset_deactivate(vcpu);

+#ifdef CONFIG_ALTIVEC
out:
+#endif
vcpu_put(vcpu);
return r;
}
-- 
2.11.0

Unfortunately I haven't found this patch in the 'kvm-ppc-next-4.16-2' [1]

@Paul
Could you please add this fix?

Thanks,
Christian

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.16-rc3&id=1ab03c072feb579c9fd116de25be2b211e6bff6a


On 28 February 2018 at 12:29PM, Geert Uytterhoeven wrote:
> On Wed, Feb 28, 2018 at 12:27 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> JFYI, when comparing v4.16-rc3[1] to v4.16-rc2[3], the summaries are:
>>    - build errors: +1/-16
>    + /home/kisskb/slave/src/arch/powerpc/kvm/powerpc.c: error: label
> 'out' defined but not used [-Werror=unused-label]:  => 1611:1
>
> ppc64_defconfig+NO_ALTIVEC
>
>> [1] http://kisskb.ellerman.id.au/kisskb/head/4a3928c6f8a53fa1aed28ccba227742486e8ddcb/ (268 out of 274 configs)
>> [3] http://kisskb.ellerman.id.au/kisskb/head/91ab883eb21325ad80f3473633f794c78ac87f51/ (all 274 configs)
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
