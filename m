Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E6A05DDE35
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Sep 2007 18:27:24 +1000 (EST)
Date: Thu, 27 Sep 2007 17:27:16 +0900 (JST)
Message-Id: <20070927.172716.-1300535245.kouish@swc.toshiba.co.jp>
To: arnd@arndb.de
Subject: Re: [PATCH 2/7] Celleb: Move pause, kexec_cpu_down to beat.c
In-Reply-To: <200709261340.51450.arnd@arndb.de>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> On Wednesday 26 September 2007, Ishizaki Kou wrote:
> > This patch is an update for "Beat on Celleb"
> >   - Move beat_pause(), beat_kexec_cpu_down() from setup.c to beat.c
> >=20
> > Signed-off-by: <Kou.Ishizaki@toshiba.co.jp>
>=20
> Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
>=20
> The patch looks good, once you fix this one line:
>=20
> > @@ -36,5 +36,9 @@ ssize_t beat_nvram_get_size(void);
> >  ssize_t beat_nvram_read(char *, size_t, loff_t *);
> >  ssize_t beat_nvram_write(char *, size_t, loff_t *);
> >  int beat_set_xdabr(unsigned long);
> > +void beat_power_save(void);
> > +#ifdef CONFIG_KEXEC
> > +void beat_kexec_cpu_down(int, int);
> > +#endif
>=20
> Function declarations in headers files should not be enclosed in =
#ifdef,
> it only causes unnecessary rebuilds when the configuration changes, =
but
> does not help.

Agreed. I'll post an updated patch.

Best regards,
Kou Ishizaki
