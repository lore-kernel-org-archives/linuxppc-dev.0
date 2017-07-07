Return-Path: <oohall@gmail.com>
MIME-Version: 1.0
In-Reply-To: <87bmoxnl9e.fsf@linux.vnet.ibm.com>
References: <1482298544-8418-1-git-send-email-oohall@gmail.com>
 <1482299579-21599-1-git-send-email-oohall@gmail.com>
 <87van7pdjn.fsf@linux.vnet.ibm.com>
 <87inj53lzk.fsf@concordia.ellerman.id.au> <87bmoxnl9e.fsf@linux.vnet.ibm.com>
From: Oliver <oohall@gmail.com>
Date: Fri, 7 Jul 2017 10:54:20 +1000
Message-ID: <CAOSf1CH3=tO4NQ+n0VyykWWjWTqQcrbDUXaS3-NkBeOzamhqOw@mail.gmail.com>
Subject: Re: [Skiboot] [RFC PATCH] powerpc/powernv: report error messages from
 opal
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 skiboot list <skiboot@lists.ozlabs.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 7, 2017 at 10:28 AM, Stewart Smith
<stewart@linux.vnet.ibm.com> wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
>> Stewart Smith <stewart@linux.vnet.ibm.com> writes:
>>> Oliver O'Halloran <oohall@gmail.com> writes:
>>>> diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
>>>> index 0e2e57bcab50..cb9c0e6afb33 100644
>>>> --- a/arch/powerpc/include/asm/opal-api.h
>>>> +++ b/arch/powerpc/include/asm/opal-api.h
>>>> @@ -167,7 +167,8 @@
>>>>  #define OPAL_INT_EOI                               124
>>>>  #define OPAL_INT_SET_MFRR                  125
>>>>  #define OPAL_PCI_TCE_KILL                  126
>>>> -#define OPAL_LAST                          126
>>>> +#define OPAL_SCRAPE_LOG                            128
>>>
>>> (another thought, along with the skiboot thoughts), I don't like the
>>> SCRAPE_LOG name so much, as it's more of a "hey linux, here's some log
>>> messages from firmware, possibly before you were
>>> involved"... OPAL_FETCH_LOG ?
>>
>> I'm not a huge fan of an interrupt followed by an opal call just to
>> fetch a single line of log.
>>
>> Can't we do something more like the existing msglog code, where we have
>> a ring buffer and then the interrupt just becomes "hey Linux you should
>> look at your ring buffer".
>
> Yeah... that would probably be a bit better...
>
> Although that would mean we can only ever tell the running kernel what's
> in the ring buffer. We couldn't work out a way to (after kexec) resend
> important bits of info such as "we garded things out, your OCC didn't
> start and we trained everything at really slow speeds"

Isn't this is the use case for BMC based error logs? A ring buffer is
fundamentally a structure for transient data. There's no real way to
hack in permanence other than making sure that making sure it never
fills.
