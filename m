Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 157E3DDF1C
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 12:54:09 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 3so703079ywj.39
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 19:54:08 -0700 (PDT)
Message-ID: <fa686aa40804131954r3c941c3cicfc922a83281ddb5@mail.gmail.com>
Date: Sun, 13 Apr 2008 20:54:08 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [EFIKA] Really, don't pretend to be CHRP
In-Reply-To: <1208105558.3026.137.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1208105558.3026.137.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 13, 2008 at 10:52 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> Fedora 9 works on Efika without the separate 'device-tree supplement',
>  thanks to the kernel's own fixups. With one exception -- because 'CHRP'
>  still appears on the 'machine:' line in /proc/cpuinfo, the installer
>  misdetects the platform and misconfigures yaboot, putting it into a PReP
>  boot partition instead of in the /boot filesystem where the Efika's
>  firmware could find it.
>
>  The kernel's fixups for Efika already correct one instance of 'chrp', in
>  the 'device_type' property. This fixes it in the 'CODEGEN,description'
>  property too, since that's what's exposed to userspace in /proc/cpuinfo.
>
>  Signed-off-by: David Woodhouse <dwmw2@infradead.org>

Looks good to me.  I don't see any reason not to pick this up.

Acked-by: Grant Likely <grant.likely@secretlab.ca>
>
>  diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
>  index 5ab4c84..723422e 100644
>  --- a/arch/powerpc/kernel/prom_init.c
>  +++ b/arch/powerpc/kernel/prom_init.c
>  @@ -2240,6 +2240,14 @@ static void __init fixup_device_tree_efika(void)
>         if (rv != PROM_ERROR && (strcmp(prop, "chrp") == 0))
>                 prom_setprop(node, "/", "device_type", "efika", sizeof("efika"));
>
>  +       /* CODEGEN,description is exposed in /proc/cpuinfo so
>  +          fix that too */
>  +       rv = prom_getprop(node, "CODEGEN,description", prop, sizeof(prop));
>  +       if (rv != PROM_ERROR && (strstr(prop, "CHRP")))
>  +               prom_setprop(node, "/", "CODEGEN,description",
>  +                            "Efika 5200B PowerPC System",
>  +                            sizeof("Efika 5200B PowerPC System"));
>  +
>         /* Fixup bestcomm interrupts property */
>         node = call_prom("finddevice", 1, 1, ADDR("/builtin/bestcomm"));
>         if (PHANDLE_VALID(node)) {
>
>
>
>  --
>  dwmw2
>
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
