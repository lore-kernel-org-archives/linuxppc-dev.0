Return-Path: <linasvepstas@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by ozlabs.org (Postfix) with ESMTP id 3F140B70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Oct 2010 12:55:27 +1100 (EST)
Received: by vws17 with SMTP id 17so176781vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 18:55:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1287103733-7121-1-git-send-email-nacc@us.ibm.com>
References: <1287103733-7121-1-git-send-email-nacc@us.ibm.com>
From: Linas Vepstas <linasvepstas@gmail.com>
Date: Thu, 14 Oct 2010 20:54:46 -0500
Message-ID: <AANLkTinEzRpREFzDVhPS5ynqjYydHOs9iW5NM6W9Tf9A@mail.gmail.com>
Subject: Re: [PATCH v2] pseries: don't override CONFIG_PPC_PSERIES_DEBUG
To: Nishanth Aravamudan <nacc@us.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Frans Pop <elendil@planet.nl>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	Brian King <brking@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
Reply-To: linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14 October 2010 19:48, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> eeh and pci_dlpar #undef DEBUG, but I think they were added before the
> ability to control this from Kconfig. It's really annoying to only get
> some of the debug messages from these files. Leave the lpar.c #undef
> alone as it produces so much output as to make the kernel unusable.
> Update the Kconfig text to indicate this particular quirk :)
>
> Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

OK, ignore my last email.

Acked by: Linas Vepstas <linasvepstas@gmail.com>


> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -47,6 +47,12 @@ config LPARCFG
> =C2=A0config PPC_PSERIES_DEBUG
> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on PPC_PSERIES && PPC_EARLY_DEBUG
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "Enable extra debug logging in platforms/=
pseries"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Say Y here if you want the pseries core to =
produce a bunch of
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 debug messages to the system log. Select th=
is if you are having a
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 problem with the pseries core and want to s=
ee more of what is
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 going on. This does not enable debugging in=
 lpar.c, which must
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 be manually done due to its verbosity.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0default y

Umm, I see "default y" and you are not changing this but ... default y
?? Really?

Also, I am guessing that the lpar spam is due only to a handful of printk's=
,
while most of the rest will be infrequent.  Just knock out the
high-frequency ones...

--linas
