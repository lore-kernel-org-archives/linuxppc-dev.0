Return-Path: <eranian@google.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78B37B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2012 22:13:27 +1100 (EST)
Received: by lags15 with SMTP id s15so5254606lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Feb 2012 03:13:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20120216045749.GA25364@bloggs.ozlabs.ibm.com>
References: <20120216154822.5bfad11d@kryten>
 <20120216045749.GA25364@bloggs.ozlabs.ibm.com>
Date: Sun, 19 Feb 2012 12:13:18 +0100
Message-ID: <CABPqkBR=Sv79YqnCG+374WdNcAJgk9VvZr7JCPxNebYMzD4Jrw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: perf: power_pmu_start restores incorrect values,
 breaking frequency events
From: Stephane Eranian <eranian@google.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=UTF-8
Cc: gleb@redhat.com, peterz@infradead.org, vince@deater.net,
 linux-kernel@vger.kernel.org, andi@firstfloor.org,
 Anton Blanchard <anton@samba.org>, imunsie@au1.ibm.com, mingo@elte.hu,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, wcohen@redhat.com,
 asharma@fb.com, emunson@mgebm.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Glad to see you fixed the PPC problem.

On Thu, Feb 16, 2012 at 5:57 AM, Paul Mackerras <paulus@samba.org> wrote:
> On Thu, Feb 16, 2012 at 03:48:22PM +1100, Anton Blanchard wrote:
>>
>> perf on POWER stopped working after commit e050e3f0a71b (perf: Fix
>> broken interrupt rate throttling). That patch exposed a bug in
>> the POWER perf_events code.
>>
>> Since the PMCs count upwards and take an exception when the top bit
>> is set, we want to write 0x80000000 - left in power_pmu_start. We were
>> instead programming in left which effectively disables the counter
>> until we eventually hit 0x80000000. This could take seconds or longer.
>>
>> With the patch applied I get the expected number of samples:
>>
>> # taskset -c 0 yes > /dev/null &
>> # perf record -C 0 -a sleep 10
>> # perf report -D | grep SAMPLE | tail -1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SAMPLE events: =C2=A0 =C2=A0 =C2=A0 9=
948
>>
>> Signed-off-by: Anton Blanchard <anton@samba.org>
>
> Acked-by: Paul Mackerras <paulus@samba.org>
