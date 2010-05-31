Return-Path: <schwab@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id CCA40B7D6C
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 May 2010 19:52:56 +1000 (EST)
From: Andreas Schwab <schwab@redhat.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU is
	not set
References: <1275270628.1931.540.camel@pasglop>
	<1275271231.1931.547.camel@pasglop>
	<FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>
Date: Mon, 31 May 2010 11:52:50 +0200
In-Reply-To: <FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de> (Alexander Graf's
	message of "Mon, 31 May 2010 11:33:40 +0200")
Message-ID: <m3ljb0tn2l.fsf@hase.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 31.05.2010, at 04:00, Benjamin Herrenschmidt wrote:
>
>> On Mon, 2010-05-31 at 11:50 +1000, Benjamin Herrenschmidt wrote:
>>> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> ---
>>> arch/powerpc/kernel/ppc_ksyms.c |    2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>> 
>> Alex, this is just a temporary fix to remove the build breakage for 40x
>> etc... but please, update KVM to just build-in its own.
>
> What's the bad part in reusing the existing code?

The bad part is that KVM is wasting a ridiculous amount of stack space
by allocating multiple instances of struct task_struct on it.  I have a
patch removing all of it, but I haven't tested it yet.

Andreas.

-- 
Andreas Schwab, schwab@redhat.com
GPG Key fingerprint = D4E8 DBE3 3813 BB5D FA84  5EC7 45C6 250E 6F00 984E
"And now for something completely different."
