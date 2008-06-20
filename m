Return-Path: <markn@au1.ibm.com>
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
Date: Fri, 20 Jun 2008 11:55:53 +1000
References: <200806191753.59599.markn@au1.ibm.com>
	<200806191643.59037.arnd@arndb.de>
In-Reply-To: <200806191643.59037.arnd@arndb.de>
MIME-Version: 1.0
Message-Id: <200806201155.53189.markn@au1.ibm.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Cc: Gunnar von Boehn <VONBOEHN@de.ibm.com>, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <ellerman@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> * The naming of the labels (with just numbers) is rather confusing,
> it would be good to have something better, but I must admit that
> I don't have a good idea either.

I will admit that at first glance the label naming with numbers
does look confusing but when you notice that all the loads start
at 20 and all the stores start at 60 and that to get the exception
handler for those instructions you just add 100 I think it makes
sense, but that could be because I've been looking at it way too
long...

(I thought I had a comment in there to that effect but it must
have gotten lost along the way. I'll add a new comment
explaining the above, that should help)

> 
> * The trick of using the condition code in cr7 for the last bytes
> is really cute, but are the four branches actually better than a
> single computed branch into the middle of 15 byte wise copies?

The original copy_tofrom_user does this also, which I guess is
carried over to this new version...

Gunnar did you have an old version that did something similar
to this?

Mark
