Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BCA41DDF0C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 06:01:38 +1100 (EST)
Date: Thu, 18 Dec 2008 22:01:36 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Long boot delay on 460EX with 2.6.28-rc8
Message-ID: <20081218190136.GA7752@oksana.dev.rtsoft.ru>
References: <21070179.post@talk.nabble.com>
	<20081218160256.GA14419@oksana.dev.rtsoft.ru>
	<A53D4E40-E15F-433B-A9DE-9359533C17F8@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <A53D4E40-E15F-433B-A9DE-9359533C17F8@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 18, 2008 at 12:51:29PM -0600, Kumar Gala wrote:
>
> On Dec 18, 2008, at 10:02 AM, Anton Vorontsov wrote:
>
>> On Thu, Dec 18, 2008 at 02:29:52AM -0800, Felix Radensky wrote:
>>>
>>> Hi,
>>>
>>> I'm experiencing a long (around 20 sec) delay from the moment
>>> u-boot-1.3.4 passes control to linux and until the first kernel  
>>> message
>>> appears on console.
>>
>> I saw somewhat similar behaviour on 83xx target, the cause was
>> that my .config file contained bogus UDBG_RTAS_CONSOLE=y symbol
>> (or was it PPC_EARLY_DEBUG_RTAS_PANEL=y? Or HVC_UDBG=y? I don't
>> quite remember).
>>
>> Obviously, on 83xx we don't have RTAS or HVC stuff, but kernel
>> didn't oops or hang completely, it was busy with executing various
>> delays in those drivers and then just continued to load.
>
> Why are these drivers even doing anything on 83xx?  Seems like they need 
> something to bind against or some detection of "HW".

Early console/UDBG is known to cause problems if enabled on
inappropriate hardware. They start working very early, so it's hard
for them to do the hw detection (no device tree yet, I presume).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
