Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id EC7112C0361
 for <linuxppc-dev@ozlabs.org>; Thu, 31 Oct 2013 23:31:45 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 29520-03 for <linuxppc-dev@ozlabs.org>;
 Thu, 31 Oct 2013 12:31:40 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: perf events ring buffer memory barrier on powerpc
Date: Thu, 31 Oct 2013 12:28:56 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B73CC@saturn3.aculab.com>
In-Reply-To: <OFDF23985D.1D949148-ON42257C15.002DEB25-42257C15.0036DF93@il.ibm.com>
References: <20131023141948.GB3566@localhost.localdomain>
 <20131025173749.GG19466@laptop.lan>
 <CAFTL4hxn47KFKZPLgKeBxxdaAbA4vg9QVzctuW4ZrSgmfX5bAQ@mail.gmail.com>
 <OFB9096CCA.68AAFFFB-ON42257C12.0044F107-42257C12.00457129@il.ibm.com>
 <20131028132634.GO19466@laptop.lan>
 <20131028163418.GD4126@linux.vnet.ibm.com>
 <20131028201735.GA15629@redhat.com>
 <OF58D85F5A.03E37A80-ON42257C12.0070E552-42257C12.00734308@il.ibm.com>
 <20131030092725.GL4126@linux.vnet.ibm.com>
 <OFC6B7100E.31C6B190-ON42257C14.004841C6-42257C14.004A0EA6@il.ibm.com>
 <20131031043258.GQ4126@linux.vnet.ibm.com>
 <OFDF23985D.1D949148-ON42257C15.002DEB25-42257C15.0036DF93@il.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Victor Kaplansky" <VICTORK@il.ibm.com>,
	<paulmck@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> "For instance, your producer must issue a "memory barrier" instruction
>   after writing the data to shared memory and before inserting it on
>   the queue; likewise, your consumer must issue a memory barrier
>   instruction after removing an item from the queue and before reading
>   from its memory.  Otherwise, you risk seeing stale data, since, =
while
>   the Alpha processor does provide coherent memory, it does not =
provide
>   implicit ordering of reads and writes.  (That is, the write of the
>   producer's data might reach memory after the write of the queue, =
such
>   that the consumer might read the new item from the queue but get the
>   previous values from the item's memory."
>=20
> If yes, I don't think it explains the need of memory barrier on Alpha
> in our case (we all agree about the need of smp_wmb() right before =
@head
> update by producer). If not, could you please point to specific =
paragraph?

My understanding is that the extra read barrier the alpha needs isn't to
control the order the cpu performs the memory cycles in, but rather to
wait while the cache system performs all outstanding operations.
So even though the wmb() in the writer ensures the writes are correctly
ordered, the reader can read the old value from the second location from
its local cache.

	David
