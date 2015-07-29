Return-Path: <thuth@redhat.com>
Message-ID: <55B86CAB.4060107@redhat.com>
Date: Wed, 29 Jul 2015 08:03:23 +0200
From: Thomas Huth <thuth@redhat.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
CC: slof@lists.ozlabs.org, nikunj@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [SLOF] [SLOF PATCH 2/2] fbuffer: Use a smaller cursor
References: <1438078795-14360-1-git-send-email-thuth@redhat.com>
 <1438078795-14360-3-git-send-email-thuth@redhat.com>
 <55B8430C.8060008@ozlabs.ru> <20150729034221.GE28839@gate.crashing.org>
In-Reply-To: <20150729034221.GE28839@gate.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29/07/15 05:42, Segher Boessenkool wrote:
> On Wed, Jul 29, 2015 at 01:05:48PM +1000, Alexey Kardashevskiy wrote:
>>>  : fb8-toggle-cursor ( -- )
>>>  	line# fb8-line2addr column# fb8-columns2bytes +
>>> -	char-height 0 ?DO
>>> +	char-height 3 - screen-width screen-depth * * +
>>> +	3 0 ?DO
>>
>> Why not just:
>>
>> -	char-height 0 ?DO
>> +	1 0 ?DO
>>
>> ? What is this magic with screen-width about?
> 
> Thomas' patch draws the cursor as the bottom three lines of a
> character cell; your suggestion would draw it as the top one line.

Right.

> But indeed it could be
> 
>   char-height dup 3 - ?DO ...

Since the loop body expects the framebuffer address on the stack, the
loop boundaries are just used to count the iterations ... so "3 0"
sounds like the easiest and most readable way to specify this IMHO.

 Thomas
