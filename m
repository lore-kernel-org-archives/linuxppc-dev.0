Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 06D60DDE36
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 21:51:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/7] Celleb: Move pause, kexec_cpu_down to beat.c
Date: Wed, 26 Sep 2007 13:40:50 +0200
References: <20070926.132314.-432833655.kouish@swc.toshiba.co.jp>
In-Reply-To: <20070926.132314.-432833655.kouish@swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709261340.51450.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 26 September 2007, Ishizaki Kou wrote:
> This patch is an update for "Beat on Celleb"
> =A0 - Move beat_pause(), beat_kexec_cpu_down() from setup.c to beat.c
>=20
> Signed-off-by: <Kou.Ishizaki@toshiba.co.jp>

Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

The patch looks good, once you fix this one line:

> @@ -36,5 +36,9 @@ ssize_t beat_nvram_get_size(void);
> =A0ssize_t beat_nvram_read(char *, size_t, loff_t *);
> =A0ssize_t beat_nvram_write(char *, size_t, loff_t *);
> =A0int beat_set_xdabr(unsigned long);
> +void beat_power_save(void);
> +#ifdef CONFIG_KEXEC
> +void beat_kexec_cpu_down(int, int);
> +#endif

=46unction declarations in headers files should not be enclosed in #ifdef,
it only causes unnecessary rebuilds when the configuration changes, but
does not help.

	Arnd <><
