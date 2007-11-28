Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from mail44-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A60A6DDDDB
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 09:59:46 +1100 (EST)
Message-ID: <474DF2D8.9010407@am.sony.com>
Date: Wed, 28 Nov 2007 14:59:36 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: PPC upstream kernel ignored DABR bug
References: <20071126220224.GA5606@host0.dyn.jankratochvil.net>
	<200711272335.36981.arnd@arndb.de>
In-Reply-To: <200711272335.36981.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Roland McGrath <roland@redhat.com>,
	Jan Kratochvil <jan.kratochvil@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Monday 26 November 2007, Jan Kratochvil wrote:
>> Hi,
>> 
>> this testcase:
>>         http://people.redhat.com/jkratoch/dabr-lost.c
>> 
>> reproduces a PPC DABR kernel bug.  The variable `variable' should not get
>> modified as the thread modifying it should be caught by its DABR:
>> 
>> $ ./dabr-lost
>> TID 30914: DABR 0x10012a77 NIP 0x80f6ebb318
>> TID 30915: DABR 0x10012a77 NIP 0x80f6ebb318
>> TID 30916: DABR 0x10012a77 NIP 0x80f6ebb318
>> TID 30914: hitting the variable
>> TID 30915: hitting the variable
>> TID 30916: hitting the variable
>> variable found = 30916, caught TID = 30914
>> TID 30916: DABR 0x10012a77
>> Variable got modified by a thread which has DABR still set!
>> 
> 
> This sounds like a bug recently reported by Uli Weigand. BenH
> said he'd take a look, but it probably fell under the table.
> The problem found by Uli is that on certain processors (Cell/B.E.
> in his case), the DABRX register needs to be set in order for
> the DABR to take effect.

Just as a note, the PS3's lv1_set_dabr(), which we used for
ppc_md.set_dabr sets up both the DABRX and DABR registers.

-Geoff
