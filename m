Return-Path: <gilad@benyossef.com>
MIME-Version: 1.0
In-Reply-To: <1325854981.2442.25.camel@twins>
References: <1325600353-10895-1-git-send-email-gilad@benyossef.com>
 <1325854981.2442.25.camel@twins>
Date: Sun, 8 Jan 2012 18:10:09 +0200
Message-ID: <CAOtvUMe0pXKTrJGhkc=OFvqYS1R_PXU9qbSAP8Ld5U7NhFvCSw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] Remove useless on_each_cpu return value
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ia64@vger.kernel.org, David Airlie <airlied@linux.ie>,
 Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Russell King <linux@arm.linux.org.uk>, x86@kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Matt Turner <mattst88@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>,
 devicetree-discuss@lists.ozlabs.org, Michal Nazarewicz <mina86@mina86.com>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Rob Herring <rob.herring@calxeda.com>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 6, 2012 at 3:03 PM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Tue, 2012-01-03 at 16:19 +0200, Gilad Ben-Yossef wrote:
>> on_each_cpu() returns as its own return value the return value of
>> smp_call_function(). smp_call_function() in turn returns a hard
>> coded value of zero.
>>
>> Some callers to on_each_cpu() waste cycles and bloat code space
>> by checking the return value to on_each_cpu(), probably for
>> historical reasons.
>
> hysterical raisins,, yumm! :-)
>
>> This patch set refactors callers to not test on_each_cpu()
>> (fixed) return value and then refactors on_each_cpu to
>> return void to avoid confusing future users.
>>
>
> Seems sane enough, fwiw:
>
> Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Thanks for the review :-)

I just sent out a V2. No changes except I've added the needed signed-off-by.

Gilad


-- 
Gilad Ben-Yossef
Chief Coffee Drinker
gilad@benyossef.com
Israel Cell: +972-52-8260388
US Cell: +1-973-8260388
http://benyossef.com

"Unfortunately, cache misses are an equal opportunity pain provider."
-- Mike Galbraith, LKML
