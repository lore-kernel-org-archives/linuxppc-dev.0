Return-Path: <michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] return to OF via trap, not exit
Date: Mon, 6 Mar 2006 12:12:08 +1100
References: <20060304191026.GA9815@suse.de>
In-Reply-To: <20060304191026.GA9815@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6927253.8VIsc50MlC";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200603061212.12815.michael@ellerman.id.au>
Cc: Olaf Hering <olh@suse.de>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart6927253.8VIsc50MlC
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sun, 5 Mar 2006 06:10, Olaf Hering wrote:
> Do not call prom exit prom_panic. It clears the screen and the exit message
> is lost. On some (or all?) pmacs it causes another crash when OF tries to
> print the date and time in its banner.
>
> Signed-off-by: Olaf Hering <olh@suse.de>
>
>  arch/powerpc/kernel/prom_init.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
>
> Index: linux-2.6.16-rc5-olh/arch/powerpc/kernel/prom_init.c
> ===================================================================
> --- linux-2.6.16-rc5-olh.orig/arch/powerpc/kernel/prom_init.c
> +++ linux-2.6.16-rc5-olh/arch/powerpc/kernel/prom_init.c
> @@ -398,7 +398,9 @@ static void __init __attribute__((noretu
>  #endif
>  	prom_print(reason);
>  	/* ToDo: should put up an SRC here on p/iSeries */
> -	call_prom("exit", 0, 0);
> +	/* Do not call exit because it clears the screen on pmac
> +	 * it also causes some sort of double-fault on early pmacs */
> +	asm("trap\n");
>
>  	for (;;)			/* should never get here */
>  		;

I don't think I like it, on IBM firmware it takes us from this:

Elapsed time since release of system processors: 26005 mins 51 secs

zImage starting: loaded at 0x00400000 (sp: 0x01a1ffe0)
Allocating 0x7edc50 bytes for kernel ...
OF version = 'IBM,SF230_126'
gunzipping (0x1c00000 <- 0x407000:0x6a04e4)...done 0x766880 bytes
OF stdout device is: /vdevice/vty@30000000
Error: You can't boot a kdump kernel from OF!
EXIT called ok
0 >


To this:

Elapsed time since release of system processors: 25995 mins 56 secs

zImage starting: loaded at 0x00400000 (sp: 0x01a1ffe0)
Allocating 0x7edc50 bytes for kernel ...
OF version = 'IBM,SF230_126'
gunzipping (0x1c00000 <- 0x407000:0x6a044b)...done 0x766880 bytes
OF stdout device is: /vdevice/vty@30000000
Error: You can't boot a kdump kernel from OF!
DEFAULT CATCH!, exception-handler=fff00700
at   %SRR0: 00000000020eaf78   %SRR1: 8000000000023002
Open Firmware exception handler entered from non-OF code

Client's Fix Pt Regs:
 00 00000000020eaf78 0000000001a1fe90 00000000023681d0 0000000000000002
 04 0000000044000024 0000000000000000 0000000000000000 0000000002063e1e
 08 0000000000000000 0000000001a1fc9c 0000000000003002 0000000000003002
 0c 2000000000000000 0000000000000000 0000000000000000 0000000000000000
 10 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 14 0000000000c00000 0000000000000008 0000000000000000 0000000000000000
 18 0000000000000000 0000000000000000 0000000000000000 0000000000c39a48
 1c c000000002453cc8 0000000002108938 0000000000000000 fffffffffffffffd
Special Regs:
    %IV: 00000700     %CR: 44000022    %XER: 00000000  %DSISR: 00000000
  %SRR0: 00000000020eaf78   %SRR1: 8000000000023002
    %LR: 00000000020eaf78    %CTR: 0000000000000000
   %DAR: 0000000000000000
Virtual PID = 0
PFW: Unable to send error log!
 ok
0 >

cheers

--nextPart6927253.8VIsc50MlC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEC4xsdSjSd0sB4dIRAiQzAJ9D46OXuv7TghRqLFZHwImkRCkqrwCgkwWB
kuV8jxFW0xYDUzqzwH3xpAM=
=Dx5Y
-----END PGP SIGNATURE-----

--nextPart6927253.8VIsc50MlC--
