Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 4440A67A6B
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 09:41:49 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [patch 02/13] powerpc: add hvc backend for rtas
Date: Thu, 23 Mar 2006 23:36:19 +0100
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060323203521.100452000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060323213217.GB5538@pb15.lixom.net>
In-Reply-To: <20060323213217.GB5538@pb15.lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603232336.19683.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Am Thursday 23 March 2006 22:32 schrieb Olof Johansson:
> > +static inline int hvc_rtas_write_console(uint32_t vtermno, const char
> > *buf, int count) +{
> > +=A0=A0=A0=A0=A0int done;
> > +
> > +=A0=A0=A0=A0=A0/* if there is more than one character to be displayed,=
 wait a bit */
> > +=A0=A0=A0=A0=A0for (done =3D 0; done < count; done++) {=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int result;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0result =3D rtas_call(rtascons_p=
ut_char_token, 1, 1, NULL, buf[done]);
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (result)=20
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0break;
>
> Why introduce a scope-local variable just to check it?
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if(rtas_call(...)) =A0 wo=
uld be cleaner.

I don't like doing the important stuff inside of another expression,
and I prefer conditions not to have side-effects.
If nobody else has a strong opinion on it, I'd prefer to leave it.

BTW, who is the current maintainer of hvc_console? Ryan is working on
glibc nowadays, right?

> > +=A0=A0=A0=A0=A0/* Really the fun isn't over until the worker thread br=
eaks down
> > and the +=A0=A0=A0=A0=A0 * tty cleans up */
> > +=A0=A0=A0=A0=A0if (hvc_rtas_dev)
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0hvc_remove(hvc_rtas_dev);
> > +}
> > +module_exit(hvc_rtas_exit); /* before drivers/char/hvc_console.c */
>
> Cryptic comment?

No idea how what it was about, I'll remove it.

	Arnd <><
