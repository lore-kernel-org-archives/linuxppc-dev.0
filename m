Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42K2WQ5vP7zDqD5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Sep 2018 10:48:50 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Arnd Bergmann <arnd@arndb.de>, Firoz Khan <firoz.khan@linaro.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxram@us.ibm.com, leitao@debian.org,
 Boqun Feng <boqun.feng@gmail.com>, gregkh <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 y2038 Mailman List <y2038@lists.linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-arch <linux-arch@vger.kernel.org>,
 Deepa Dinamani <deepa.kernel@gmail.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation support
In-Reply-To: <CAK8P3a2hi-Ndh7X-9r3NhBUJXQBTBFsTU==GbHesy6YD9idCJA@mail.gmail.com>
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
 <1536913980-4811-3-git-send-email-firoz.khan@linaro.org>
 <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
 <CALxhOngVYQRwbcUg6c_3LcKAEoBwyN1B478LqRGmWEGL004--w@mail.gmail.com>
 <CAK8P3a2hi-Ndh7X-9r3NhBUJXQBTBFsTU==GbHesy6YD9idCJA@mail.gmail.com>
Date: Tue, 25 Sep 2018 10:48:49 +1000
Message-ID: <87efdi5rm6.fsf@concordia.ellerman.id.au>
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

Arnd Bergmann <arnd@arndb.de> writes:
> On Tue, Sep 18, 2018 at 2:15 PM Firoz Khan <firoz.khan@linaro.org> wrote:
>> On 14 September 2018 at 15:31, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Fri, Sep 14, 2018 at 10:33 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>> >
>> >> ---
>> >>  arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
>> >>  arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 ++++++++++++++++++++++++++++
>> >>  arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 +++++++++++++++++++++++++++
>> >>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
>> >>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++
>> >
>> > I think you should only need a single .tbl  input file here.
>>
>> Yes, we can do that way also.As I mentioned, it will add
>> more complexity in the script.
>>
>>  The script has to be smart enough to parse the
>> .tbl if we add more thing in the .tble file. It need more
>> logic in the scripts. This is not common. So if you keep
>> separate .tbl we can avoid this.
>
> But all three existing architectures (x86, s390 and arm) already
> have the capability to parse the table and generate different output
> from that.

Yeah, we want that on powerpc too.

If the script needs to be more complex that's fine, if it can't be
shared across arches that's fine, the main thing for me is that wiring
up a syscall can be done by adding a single line in a single file.

cheers
