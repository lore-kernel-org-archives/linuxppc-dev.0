Return-Path: <arnd@arndb.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 991D9B713B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Jul 2009 01:56:50 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] powerpc/cell: strncpy does not null terminate string
Date: Fri, 17 Jul 2009 17:56:21 +0200
References: <4A607185.6020302@gmail.com> <4A608A69.4060204@gmail.com>
In-Reply-To: <4A608A69.4060204@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200907171756.22224.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 17 July 2009, Roel Kluin wrote:
> 
>  static int __init celleb_machine_type_hack(char *ptr)
>  {
> -       strncpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
> +       strlcpy(celleb_machine_type, ptr, sizeof(celleb_machine_type));
>         celleb_machine_type[sizeof(celleb_machine_type)-1] = 0;
>         return 0;

This still is pointless as long as you keep the explicit null-termination
in the next line, the patch still doesn't change anything significant.

The file is maintained by Ishizaki Kou, if he would prefer to take a
patch replacing the two lines with one, that's fine with me, otherwise
I just wouldn't bother. You still only gain a few bytes of inittext, but
that is discarded at boot time.

	Arnd <><
