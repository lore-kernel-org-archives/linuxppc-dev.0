Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x22b.google.com (mail-qk0-x22b.google.com
 [IPv6:2607:f8b0:400d:c09::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZvYz3CDVzDqk3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 18:21:27 +1000 (AEST)
Received: by mail-qk0-x22b.google.com with SMTP id a186so97914497qkf.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 01:21:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHj3AV=V2s2ymM7Sg8TsmuqkopXmGjDceC0c=K1-_BuLQqPvEQ@mail.gmail.com>
References: <1466666639-10480-1-git-send-email-oohall@gmail.com>
 <CAHj3AV=V2s2ymM7Sg8TsmuqkopXmGjDceC0c=K1-_BuLQqPvEQ@mail.gmail.com>
From: oliver <oohall@gmail.com>
Date: Thu, 23 Jun 2016 18:21:23 +1000
Message-ID: <CAOSf1CGEncYNgqi4gj0SK_v98mypcomgFgngbFjahSx3pnTccA@mail.gmail.com>
Subject: Re: [PATCHv4] powerpc/timer - large decrementer support
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 Jack Miller <jack@codezen.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 23, 2016 at 6:02 PM, Denis Kirjanov <kirjanov@gmail.com> wrote:
> On 6/23/16, Oliver O'Halloran <oohall@gmail.com> wrote:
>> +static void __init set_decrementer_max(void)
>> +{
>> +     struct device_node *cpu;
>> +     const __be32 *fp;
>> +     u64 bits = 32;
>> +
>> +     /* Prior to ISAv3 the decrementer is always 32 bit */
>> +     if (!cpu_has_feature(CPU_FTR_ARCH_300))
>> +             return;
>> +
>> +     cpu = of_find_node_by_type(NULL, "cpu");
>> +     if (cpu)
>> +             fp = of_get_property(cpu, "ibm,dec-bits", NULL);
>> +
>> +     if (cpu && fp) {
>> +             bits = of_read_number(fp, 1);
>> +
>> +             if (bits > 64 || bits < 32) {
>> +                     pr_warn("time_init: firmware supplied invalid ibm,dec-bits");
>> +                     bits = 32;
>> +             }
>> +
>> +
>> +             /* calculate the signed maximum given this many bits */
>> +             decrementer_max = (1ul << (bits - 1)) - 1;
>> +     }
>> +
>> +     pr_info("time_init: %llu bit decrementer (max: %llx)\n",
>> +             bits, decrementer_max);
>> +}
> the call to of_node_put(cpu) is missing in the function.

Well spotted, thanks.
