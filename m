Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5061D679F1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 01:19:07 +1000 (EST)
In-Reply-To: <Pine.LNX.4.63.0505061718380.6288@xmission.xmission.com>
References: <Pine.LNX.4.63.0505061718380.6288@xmission.xmission.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <b0aede90eb15562c0dd5a44c10d1b965@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 9 May 2005 10:19:01 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Tom Rini <trini@kernel.crashing.org>,
	"<cpclark@xmission.com> <cpclark@xmission.com>" <cpclark@xmission.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: PPC uImage build not reporting correctly
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 6, 2005, at 6:22 PM, <cpclark@xmission.com> wrote:

> On Fri, 6 May 2005, Kumar Gala wrote:
>  > I tried the following w/o success:
>  >
> > $(obj)/uImage: $(obj)/vmlinux.gz
> >=A0=A0=A0=A0=A0=A0=A0=A0 $(Q)rm -f $@
>  >=A0=A0=A0=A0=A0=A0=A0=A0 $(call if_changed,uimage)
> >=A0=A0=A0=A0=A0=A0=A0=A0 @echo '=A0 Image: $@' $(shell if [ -f $@ ]; =
then echo 'is=20
> ready'; else
>  > echo 'not made'; fi)
>
> Couldn't you eliminate the ($shell ..) construct altogether, like=20
> this?:
>
> $(obj)/uImage: $(obj)/vmlinux.gz
> =A0=A0=A0=A0=A0=A0=A0 $(Q)rm -f $@
>  =A0=A0=A0=A0=A0=A0=A0 $(call if_changed,uimage)
> =A0=A0=A0=A0=A0=A0=A0 @echo -n '=A0 Image: $@'
>  =A0=A0=A0=A0=A0=A0=A0 @if [ -f $@ ]; then echo 'is ready' ; else echo =
'not made'; fi

Yes, and this seems to actually work.

Sam, does this look reasonable to you.  If so I will work up a patch.

thanks

- kumar
