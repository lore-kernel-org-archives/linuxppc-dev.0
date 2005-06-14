Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp16.mail.mci.yahoo.co.jp (ybbsmtp16.mail.mci.yahoo.co.jp
	[210.80.241.190]) by ozlabs.org (Postfix) with SMTP id 94BA3679E6
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Jun 2005 22:47:49 +1000 (EST)
Message-ID: <42AED064.2090305@ybb.ne.jp>
Date: Tue, 14 Jun 2005 21:41:08 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B8593BC@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B8593BC@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: boot time scheduling hile atomic
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi

IMHO, it is more preferable to change kernel thread creation mechanism adapting to
other architecture(in stead of tweaking exception handling) to solve the issue at least.
Of course, cleaning up the exception codes to adapt to ppc64  is also preferable from
code maintenance view.

Anyway, please try to apply the patch as follow:
http://ozlabs.org/ppc32-patches/patch.pl?id=318

Rune Torgersen wrote:
> Any patch forthcomming soon? 
> 
> 
>>-----Original Message-----
>>From: linuxppc-dev-bounces@ozlabs.org 
>>[mailto:linuxppc-dev-bounces@ozlabs.org] On Behalf Of 
>>Benjamin Herrenschmidt
>>Sent: Wednesday, March 16, 2005 16:29
>>To: Takeharu KATO
>>Cc: linuxppc-dev list
>>Subject: Re: boot time scheduling hile atomic
>>
>>On Wed, 2005-03-16 at 23:07 +0900, Takeharu KATO wrote:
>>
>>>Hi Benjamin:
>>>
>>>I can not figure out why my previous patch is more preferable than
>>>later one.
>>>Could you explain the reason of that please.
>>
>>There may be other kernel bits calling syscall, it sounds saner to
>>always make sure we don't reschedule when in atomic (though 
>>it's dubious
>>that it's allowed to do syscalls in atomic regions, let's be safe
>>there).
>>
>>In fact, we are thinking about consolidating the syscall 
>>return path and
>>the normal irq return path like we did on ppc64.
>>
>>Ben.
>>
>>
>>_______________________________________________
>>Linuxppc-dev mailing list
>>Linuxppc-dev@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>
>>
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
