Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xzCPy0xXyzDr5G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 22:26:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-next <linux-next@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Rob Herring <robh@kernel.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [linux-next][DLPAR CPU][Oops] Bad kernel stack pointer
In-Reply-To: <1506074224.17232.8.camel@abdul.in.ibm.com>
References: <1505729319.6990.5.camel@abdul.in.ibm.com>
 <878th9lhpe.fsf@concordia.ellerman.id.au>
 <1506074224.17232.8.camel@abdul.in.ibm.com>
Date: Fri, 22 Sep 2017 22:26:10 +1000
Message-ID: <87poaiudgd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:

> On Wed, 2017-09-20 at 21:42 +1000, Michael Ellerman wrote:
>> Abdul Haleem <abdhalee@linux.vnet.ibm.com> writes:
>> 
>> > Hi,
>> >
>> > Dynamic CPU remove operation resulted in Kernel Panic on today's
>> > next-20170915 kernel.
>> >
>> > Machine Type: Power 7 PowerVM LPAR
>> > Kernel : 4.13.0-next-20170915
>> > config : attached
>> > test: DLPAR CPU remove
>> >
>> >
>> > dmesg logs:
>> > ----------
>> > cpu 37 (hwid 37) Ready to die...
>> > cpu 38 (hwid 38) Ready to die...
>> > cpu 39 (hwid 39)
>> > ******* RTAS CReady to die...
>> > ALL BUFFER CORRUPTION *******
>> 
>> Cool. Does that come from RTAS itself? I have never seen that happen
>> before.
>
> Not sure, the var logs does not have any messages captured. This is
> first time we hit this type of issue.

Yeah it is from RTAS:

# lsprop /proc/device-tree/rtas/linux,rtas-base 
/proc/device-tree/rtas/linux,rtas-base
		 1eca0000 (516554752)
# lsprop /proc/device-tree/rtas/rtas-size
/proc/device-tree/rtas/rtas-size
		 01360000 (20316160)

# dd if=/dev/mem bs=4096 skip=126112 count=4960 of=rtas.bin
# strings rtas.bin | grep "RTAS CALL BUFFER"
******* RTAS CALL BUFFER CORRUPTION *******


So we were doing an RTAS call and RTAS itself detected that the call
buffer was corrupted. I'm not sure how it detects that, but something is
definitely screwed up.

>> Is this easily reproducible?
>
> I am unable to reproduce it again. I will keep an eye on our CI runs for
> few more runs.

OK thanks.

cheers
