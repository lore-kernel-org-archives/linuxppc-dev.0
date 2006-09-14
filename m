Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 5F34D67B5F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 08:49:11 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so102886ugc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Sep 2006 15:49:09 -0700 (PDT)
Message-ID: <528646bc0609141549p319f01dfwb0d2897bb0bdc41f@mail.gmail.com>
Date: Thu, 14 Sep 2006 16:49:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "John Bonesio" <john.bonesio@xilinx.com>
Subject: Re: Ethernet driver for Linux kernel 2.6 running on ML403
In-Reply-To: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA645@XSJ-EXCHVS1.xlnx.xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <2FE3DBF1797A1443AAB3FA0EF6BF4EEC021EA645@XSJ-EXCHVS1.xlnx.xilinx.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/14/06, John Bonesio <john.bonesio@xilinx.com> wrote:

<snip>

> << Same complaints apply for Xilinx drivers in the U-Boot bootloader.
> It is proving very difficult to get Xilinx code into U-Boot which means
> BSPs that use the code are hard to get submitted as well.>>
>
> I've only touched on U-Boot a little bit. Have any thoughts on how to
> make this easier?

U-Boot has the same issues as Linux
- Xilinx drivers don't match the coding style
- The license boilerplate is not GPL compatible
- The IP can change rapidly, so do the drivers belong in the u-boot
mainline tree?
- Current code is not set up to support multiple drivers in the code
base.  (I know it's possible, but it's not being done at the moment)

(and see my comments on Linux below)

>
> << The Xilinx approach of overwriting the source tree just feels wrong,
> and no one seems to want to do it that way.>>
>
> I am in the group that has control over how this is done. What would you
> propose be done different? Keep in mind that we are trying to support a
> process where someone builds a hardware design and the later changes it
> with new peripherals or perhaps makes minor tweaks. We want to make the
> updating of the Linux kernel to reflect these hardware changes easy for
> people.

Simply generating code and inserting it into the kernel tree itself is
okay on the surface, but the current scheme is distasteful.  I would
make the following recommendations to make it more palatable:
- Keep generated code in a single sub-directory.  Don't scatter it all
over the kernel source.  ie. generate all code into /xilinx-bsp
instead of bits into /arch/ppc and /drivers.
- Don't overwrite *anything* that from the mainline tree.  (Hence the
/xilinx-bsp suggestion above).  If you need to modify files in the
tree, like in /arch/ppc, then submit patches for the needed changes
and *don't* try to modify them from within EDK.
- If you want something in mainline; make sure it can coexist with
drivers for other versions of the same IP, or make it support multiple
versions.
- Corollary to the above two points; once a Xilinx provided
patch/driver is accepted into mainline, treat it like the rest of
mainline and don't let EDK overwrite it.
- Regardless of Xilinx's intentions, 3rd party drivers will probably
be written and accepted into mainline.  Be prepared to coexist with
them also.
- Stop requiring xparameters.h to be mangled!  Generate it correctly
the first time!  I think I'll scream if I get handed another xparams
file from an FPGA engineer which was generated as a no-os target.  The
Linux redefines are useful, why aren't they in xparameters.h for all
targets?

Unfortunately, generating the drivers ends up being a one way street.
If the code is not in mainline, it will not keep up with changes to
the kernel API, and it is more difficult to get bug fixes into the
driver code from 3rd parties (ie. users need to wait for the next EDK
release cycle before the changes appear in generated code).  This is
probably the major reason why writing new 3rd party drivers for
inclusion in mainline is attractive to me.

>
> Having the ability to make rapid hardware changes, I think, is a bit
> different from what most folks are used to.

Different, but manageable.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
