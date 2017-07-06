Return-Path: <mpe@ellerman.id.au>
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, skiboot@lists.ozlabs.org
Cc: linuxppc-dev@lists.ozlabs.org, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [Skiboot] [RFC PATCH] powerpc/powernv: report error messages from
 opal
In-Reply-To: <87van7pdjn.fsf@linux.vnet.ibm.com>
References: <1482298544-8418-1-git-send-email-oohall@gmail.com>
 <1482299579-21599-1-git-send-email-oohall@gmail.com>
 <87van7pdjn.fsf@linux.vnet.ibm.com>
Date: Thu, 06 Jul 2017 20:20:31 +1000
Message-ID: <87inj53lzk.fsf@concordia.ellerman.id.au>
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

Stewart Smith <stewart@linux.vnet.ibm.com> writes:
> Oliver O'Halloran <oohall@gmail.com> writes:
>> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
>> index 0e2e57bcab50..cb9c0e6afb33 100644
>> --- a/arch/powerpc/include/asm/opal-api.h
>> +++ b/arch/powerpc/include/asm/opal-api.h
>> @@ -167,7 +167,8 @@
>>  #define OPAL_INT_EOI				124
>>  #define OPAL_INT_SET_MFRR			125
>>  #define OPAL_PCI_TCE_KILL			126
>> -#define OPAL_LAST				126
>> +#define OPAL_SCRAPE_LOG				128
>
> (another thought, along with the skiboot thoughts), I don't like the
> SCRAPE_LOG name so much, as it's more of a "hey linux, here's some log
> messages from firmware, possibly before you were
> involved"... OPAL_FETCH_LOG ?

I'm not a huge fan of an interrupt followed by an opal call just to
fetch a single line of log.

Can't we do something more like the existing msglog code, where we have
a ring buffer and then the interrupt just becomes "hey Linux you should
look at your ring buffer".

cheers
