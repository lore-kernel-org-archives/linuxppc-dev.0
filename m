Return-Path: <glikely@secretlab.ca>
Received: from mail-ew0-f50.google.com (mail-ew0-f50.google.com
	[209.85.215.50]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2DC46B6F94
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 14:31:15 +1000 (EST)
Received: by ewy22 with SMTP id 22so228480ewy.23
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2011 21:31:11 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1316490307-28030-6-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
	<1316490307-28030-6-git-send-email-benh@kernel.crashing.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 19 Sep 2011 22:30:49 -0600
Message-ID: <CACxGe6vxC4xq8OOVWfs2cMKzDe_R2ELu4WvVR9wxfft1RovQTg@mail.gmail.com>
Subject: Re: [PATCH 06/20] of: Change logic to overwrite cmd_line with
	CONFIG_CMDLINE
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 19, 2011 at 9:44 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> We used to overwrite with CONFIG_CMDLINE if we found a chosen
> node but failed to get bootargs out of it or they were empty,
> unless CONFIG_CMDLINE_FORCE is set.
>
> Instead change that to overwrite if cmd_line is non empty after
> the bootargs check. It allows arch code to have other mechanisms
> to retrieve the command line prior to parsing the device-tree.
>
> Note: CONFIG_CMDLINE_FORCE case should ideally be handled elsewhere
> as it won't work as it-is if the device-tree has no /chosen node
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

But while you're in there, you should comment what you described in
the commit text.  Namely that CONFIG_CMDLINE is a last resort if
nothing else managed to set the command line.

g.

> ---
> =A0drivers/of/fdt.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 65200af..d382163 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -683,7 +683,7 @@ int __init early_init_dt_scan_chosen(unsigned long no=
de, const char *uname,
>
> =A0#ifdef CONFIG_CMDLINE
> =A0#ifndef CONFIG_CMDLINE_FORCE
> - =A0 =A0 =A0 if (p =3D=3D NULL || l =3D=3D 0 || (l =3D=3D 1 && (*p) =3D=
=3D 0))
> + =A0 =A0 =A0 if (!cmd_line[0])
> =A0#endif
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strlcpy(data, CONFIG_CMDLINE, COMMAND_LINE=
_SIZE);
> =A0#endif /* CONFIG_CMDLINE */
> --
> 1.7.4.1
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
