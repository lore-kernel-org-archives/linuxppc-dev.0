Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 25A3EB7D6E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Jun 2010 01:52:38 +1000 (EST)
Message-ID: <4C03DB3D.7090007@suse.de>
Date: Mon, 31 May 2010 17:52:29 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Andreas Schwab <schwab@redhat.com>
Subject: Re: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU
	is not set
References: <1275270628.1931.540.camel@pasglop>	<1275271231.1931.547.camel@pasglop>	<FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>
	<m3ljb0tn2l.fsf@hase.home>
In-Reply-To: <m3ljb0tn2l.fsf@hase.home>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> Alexander Graf <agraf@suse.de> writes:
>
>   
>> On 31.05.2010, at 04:00, Benjamin Herrenschmidt wrote:
>>
>>     
>>> On Mon, 2010-05-31 at 11:50 +1000, Benjamin Herrenschmidt wrote:
>>>       
>>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>> ---
>>>> arch/powerpc/kernel/ppc_ksyms.c |    2 +-
>>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>>         
>>> Alex, this is just a temporary fix to remove the build breakage for 40x
>>> etc... but please, update KVM to just build-in its own.
>>>       
>> What's the bad part in reusing the existing code?
>>     
>
> The bad part is that KVM is wasting a ridiculous amount of stack space
> by allocating multiple instances of struct task_struct on it.  I have a
> patch removing all of it, but I haven't tested it yet.
>   

Mind to send it over so I can take a look at it :)? Getting rid of the
task_struct structs lying in the stack is certainly a good idea.

Alex
