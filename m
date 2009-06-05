Return-Path: <glikely@secretlab.ca>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.157])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 7301EB70A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 09:53:18 +1000 (EST)
Received: by yw-out-1718.google.com with SMTP id 5so931375ywm.32
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 05 Jun 2009 16:53:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <461095.11075.qm@web111310.mail.gq1.yahoo.com>
References: <461095.11075.qm@web111310.mail.gq1.yahoo.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 5 Jun 2009 17:52:56 -0600
Message-ID: <fa686aa40906051652r2f978065ife1fa71de7f8b5eb@mail.gmail.com>
Subject: Re: Add "mpc5200-simple-platform" to the list of supported boards
To: Marcelo Dalmas <m_dalmas@yahoo.com.br>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 5, 2009 at 5:20 PM, Marcelo Dalmas<m_dalmas@yahoo.com.br> wrote=
:
>
> Hello,
>
> Adding =A0"mpc5200-simple-platform" to the list of supported boards allow=
 to use the option "Generic support for simple MPC5200 based boards" withou=
t patching the kernel. Just set model to "mpc5200-simple-plataform" on your=
 dts file.
>
>
> diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/=
platforms/52xx/mpc5200_simple.c
> index c31e5b5..a2df795 100644
> --- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> @@ -50,6 +50,7 @@ static void __init mpc5200_simple_setup_arch(void)
>
> =A0/* list of the supported boards */
> =A0static char *board[] __initdata =3D {
> + =A0 =A0 =A0 "mpc5200-simple-platform",
> =A0 =A0 =A0 =A0"intercontrol,digsy-mtc",
> =A0 =A0 =A0 =A0"phytec,pcm030",
> =A0 =A0 =A0 =A0"phytec,pcm032",

Sorry, nack.  For the time being, board support is listed explicitly
in mpc5200_simple.c and 'generic' compatible values are strongly
discouraged.  This is on purpose.

I have been thinking about coming up with a method for generic mpc5200
platform support code to bind against an otherwise unknown mpc5200
board, but there are subtleties here and considerable pain if it is
done wrong.

In the mean time, just patch your kernel with your board name(s) and
don't try to use a generic value like mpc5200-simple-platform.

BTW, please cc: the appropriate maintainers and developers when
posting patches to the Linux kernel.  The MAINTAINERS file and
'scripts/get_maintainer.pl -f <filename>' are useful tools here.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
