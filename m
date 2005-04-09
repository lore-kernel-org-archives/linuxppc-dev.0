Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16983.8839.391784.458466@cargo.ozlabs.ibm.com>
Date: Sat, 9 Apr 2005 10:32:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20050408184442.GA13709@iram.es>
References: <20050408082635.GB4992@iram.es>
	<8fc7723059937dc9876c5c14fdcd92ae@freescale.com>
	<20050408184442.GA13709@iram.es>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-ppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: pte_update and 64-bit PTEs on PPC32?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Gabriel Paubert writes:

> But I'm not sure that OOO cannot play tricks on you, what guarantees
> that the lwz is done after lwarx?

Nothing, but it doesn't matter, because we have the
mm->page_table_lock, and anything that is changing the top 32 bits, or
anything in the bottom 32 bits other than the _PAGE_HASHPTE bit,
must also take the mm->page_table_lock.  The low-level hash_page
routine can change the _PAGE_HASHPTE bit without having that lock,
which is why we need the atomic sequence.

Paul.
