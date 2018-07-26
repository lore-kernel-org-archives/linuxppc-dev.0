Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bbRq4PhbzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 12:20:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Cc: linux-kernel@vger.kernel.org, Alastair D'Silva <alastair@d-silva.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Cyril Bur <cyrilbur@gmail.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@samba.org>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 "Tobin C . Harding" <me@tobin.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/7] powerpc: Modernize unhandled signals message
In-Reply-To: <20180725193647.GA23643@kermit-br-ibm-com>
References: <20180724192720.32417-1-muriloo@linux.ibm.com>
 <0f185351330a7f1d66409fe6a2dc02aae6826039.camel@neuling.org>
 <20180725193647.GA23643@kermit-br-ibm-com>
Date: Thu, 26 Jul 2018 12:20:52 +1000
Message-ID: <87wotihh4r.fsf@concordia.ellerman.id.au>
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

Murilo Opsfelder Araujo <muriloo@linux.ibm.com> writes:
> On Wed, Jul 25, 2018 at 05:00:21PM +1000, Michael Neuling wrote:
>>  On Tue, 2018-07-24 at 16:27 -0300, Murilo Opsfelder Araujo wrote:
>> > This series was inspired by the need to modernize and display more
>> > informative messages about unhandled signals.
...
>> 
>> Nice.. the instruction dump would have been very handy when debugging the PCR
>> init issue I had a month or so back.

These things may be related :)

>> What happens if we get a sudden flood of these from different processes that
>> overlap their output? Are we going to be able to match up the process with
>> instruction dump?
>
> As to the flood of messages, ___ratelimit() makes me think that we'll
> likely see some warn messages informing how many show_signal_msg()
> callbacks were suppressed, instead of interleaved messages and
> instruction dumps.
>
> As to matching process with instruction dump, I believe we'd need more
> information to glue them together.
>
> What if we modify show_instructions() to accept a string prefix to be
> printed along with each line?
>
>> Should we prefix every line with the PID to avoid this?
>
> That's possible.  An alternative would be prefixing each line with the
> process name and its PID, as in the first line.  For example:
>
>     pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
>     pandafault[10758]: Instruction dump:
>     pandafault[10758]: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
>     pandafault[10758]: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040
>
> The above can be interleaved with other messages and we'll still be able
> to match process and its corresponding instruction dump.

Yeah prefixing with the comm and pid is nice.

Also the "Instruction dump:" line is a waste of space.

I prefer the x86 format, where it's prefixed with "code:", eg:

  pandafault[10758]: segfault (11) at 00000000100007d0 nip 000000001000061c lr 00007fffabc85100 code 2 in pandafault[10000000+10000]
  pandafault[10758]: code: 4bfffeec 4bfffee8 3c401002 38427f00 fbe1fff8 f821ffc1 7c3f0b78 3d22fffe
  pandafault[10758]: code: 392988d0 f93f0020 e93f0020 39400048 <99490000> 39200000 7d234b78 383f0040

cheers
