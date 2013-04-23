Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 63F242C0169
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 14:14:55 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 00:14:51 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 43B77C9001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 00:14:48 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3N4Emio44236858
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 00:14:48 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3N4ElUn030607
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 00:14:48 -0400
Date: Tue, 23 Apr 2013 12:14:41 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 3/3] powerpc/powernv: Patch MSI EOI handler on P8
Message-ID: <20130423041441.GA2846@shangw.(null)>
References: <1366363965-23281-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1366363965-23281-3-git-send-email-shangw@linux.vnet.ibm.com>
 <20130421233436.GB22246@concordia>
 <20130422014533.GA7902@shangw.(null)>
 <20130422025636.GB24739@concordia>
 <20130422110617.GA21476@shangw.(null)>
 <20130422233415.GB17406@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130422233415.GB17406@concordia>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 23, 2013 at 09:34:16AM +1000, Michael Ellerman wrote:
>On Mon, Apr 22, 2013 at 07:06:17PM +0800, Gavin Shan wrote:
>> On Mon, Apr 22, 2013 at 12:56:37PM +1000, Michael Ellerman wrote:
>> >On Mon, Apr 22, 2013 at 09:45:33AM +0800, Gavin Shan wrote:
>> >> On Mon, Apr 22, 2013 at 09:34:36AM +1000, Michael Ellerman wrote:
>> >> >On Fri, Apr 19, 2013 at 05:32:45PM +0800, Gavin Shan wrote:

.../...

>> >> >> diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerp=
c/sysdev/xics/icp-native.c
>> >> >> index 48861d3..289355e 100644
>> >> >> --- a/arch/powerpc/sysdev/xics/icp-native.c
>> >> >> +++ b/arch/powerpc/sysdev/xics/icp-native.c
>> >> >> @@ -27,6 +27,10 @@
>> >> >>  #include <asm/xics.h>
>> >> >>  #include <asm/kvm_ppc.h>
>> >> >> =20
>> >> >> +#if defined(CONFIG_PPC_POWERNV) && defined(CONFIG_PCI_MSI)
>> >> >> +extern int pnv_pci_msi_eoi(unsigned int hw_irq);
>> >> >> +#endif
>> >> >
>> >> >You don't need to #ifdef the extern. But it should be in a header,=
 not
>> >> >here.
>> >> >
>> >>=20
>> >> Ok. I'll put it into asm/xics.h, but I want to confirm we needn't
>> >> #ifdef when moving it to asm/xics.h?
>> >
>> >No you don't need it #ifdef'd. It's just extra noise in the file, and
>> >doesn't really add anything IMHO.
>> >
>>=20
>> Michael, I'm a bit confused about your point. asm/xics.h is shared bet=
ween
>> PowerNV and pSeries platform, and pnv_pci_msi_eoi() is only implemente=
d on
>> PowerNV platform, so the code should look like this (with newly introd=
uced
>> option - CONFIG_POWERNV_MSI)
>>=20
>> #ifdef CONFIG_POWERNV_MSI
>> extern int pnv_pci_msi_eoi(unsigned int hw_irq);
>> #endif
>
>You can do that. But there's not much value added by adding an
>#ifdef around the extern.
>
>Assuming the body of pnv_pci_msi_eoi() is only available when
>CONFIG_POWERNV_MSI is defined (which is the whole point), imagine there
>is code in platforms/pseries which accidentally calls it.
>
>If we have the extern protected by an ifdef we will get a warning that
>we are calling an undeclared function, eg something like:
>
>  pseries.c:30:2: warning: implicit declaration of function =E2=80=98pnv=
_pci_msi_eoi=E2=80=99 [-Wimplicit-function-declaration]
>
>But more importantly we will not be able to link the kernel, because the
>body of pnv_pci_msi_eoi() is missing (because CONFIG_POWERNV_MSI=3Dn).
>
>If we have the extern visible in the header, ie. not inside #ifdef, then
>we will not see the warning because the compiler can see the
>declaration.
>
>But even so the kernel will still not link.
>
>So my point is that having the #ifdef around the extern just gives you
>an extra warning, which is not all that useful because you are going to
>notice anyway as soon as the kernel fails to link.
>
>Anyway it's a minor point so don't worry about it too much :)
>

Thanks for your time to explain it with details, Michael. I will
remove that "#ifdef" ;-)

Thanks,
Gavin
