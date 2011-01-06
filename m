Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1725AB7043
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jan 2011 03:58:02 +1100 (EST)
MIME-Version: 1.0
In-Reply-To: <4D25BB08.7000001@evidence.eu.com>
References: <4D25BB08.7000001@evidence.eu.com>,
	<AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>	<4D24B725.2020300@evidence.eu.com>
	<20110105174256.29fd378a@udp111988uds.am.freescale.net>
Subject: Re: mpc880 linux-2.6.32 slow running processes
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: michael@evidence.eu.com
Message-ID: <OFB0350E05.07B070EF-ONC1257810.005CAF17-C1257810.005CAF19@transmode.se>
Date: Thu, 6 Jan 2011 17:52:21 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: scottwood <scottwood@freescale.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	RFeany <RFeany@mrv.com>, rbeims <rbeims@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



>>> +  /* On 8xx, cache control instructions (particularly
>>> +   * "dcbst" from flush=5Fdcache=5Ficache) fault as write
>>> +   * operation if there is an unpopulated TLB entry
>>> +   * for the address in question. To workaround that,
>>> +   * we invalidate the TLB here, thus avoiding dcbst
>>> +   * misbehaviour.
>>> +   */
>>> +  /* 8xx doesn't care about PID, size or ind args */
>>> +  =5Ftlbil=5Fva(addr, 0, 0, 0);
>>>   #endif /* CONFIG=5F8xx */
>>> +
>>> +  if (!pg)
>>> +   return pte;
>>> +
>>> +  if (!PageReserved(pg)&&  !test=5Fbit(PG=5Farch=5F1,&pg->flags)) {
>>>      flush=5Fdcache=5Ficache=5Fpage(pg);
>>>      set=5Fbit(PG=5Farch=5F1,&pg->flags);
>>>     }
>> Rex, do you recall under what specific circumstances the =5Ftlbil=5Fva is
>> needed?  Is it possible that it will be caused by a dcbst in other
>> contexts that are not dependent on the state of PG=5Farch=5F1?

The 8xx tlbil=5Fva should not be needed in recent 2.6 after I fixed the 8xx=
 TLB code
to workaround the dcbst bug there instead. See=20
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
itdiff;h=3D0a2ab51ffb8dfdf51402dcfb446629648c96bc78;hp=3D60e071fee994ff98c3=
7d03a4a7c5a3f8b1e3b8e5

Not sure what release it went into though.

 Jocke=
=
