Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id E3F52DDE24
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 08:56:54 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [patch 3/3] PS3: Add logical performance monitor driver support
Date: Sun, 6 Jan 2008 22:56:17 +0100
References: <20080105003019.595703814@am.sony.com>
	<200801051256.22732.arnd@arndb.de> <47813CA4.8000203@am.sony.com>
In-Reply-To: <47813CA4.8000203@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801062256.18885.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Takashi Yamamoto <Takashi02_Yamamoto@hq.scei.sony.co.jp>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 06 January 2008, Geoff Levand wrote:
> 
> > This mutex is documented as the 'open/close' mutex and you use it
> > to prevent concurrent execution of the open and close functions.
> > However, it's unclear what data structures are actually protected
> > by it.
> > 
> > I think this is the result of unusual lifetime rules for the lpm_priv
> > object, which I already mentioned above.
> 
> Yes, we really just need to use the mutex to allow only a single instance,
> and so do a mutex_trylock() in ps3_lpm_open() and return -EBUSY on fail,
> and then a mutex_unlock() in ps3_lpm_close().

A simple atomic_test_and_set in open() should do the job just as well then.

	Arnd <><
