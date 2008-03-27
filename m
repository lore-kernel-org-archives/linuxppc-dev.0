Return-Path: <olof@lixom.net>
Date: Thu, 27 Mar 2008 14:22:04 -0500
From: Olof Johansson <olof@lixom.net>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 0/2] Two more pasemi_mac patches for 2.6.26
Message-ID: <20080327192204.GA17881@lixom.net>
References: <20080326015625.GA23103@lixom.net> <47E9CD2E.7040203@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47E9CD2E.7040203@pobox.com>
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 26, 2008 at 12:12:30AM -0400, Jeff Garzik wrote:
> Olof Johansson wrote:
>> Hi Jeff,
>>
>> The below two patches go on top of the previous patches that were acked
>> by you but applied to pasemi.git for feed up through powerpc.git.
>>
>> One is a couple of fixes for various corner cases in the jumbo support
>> configuration. The second is addition of netpoll support, from Nate
>> Case.
>>
>> Review/ack would be appreciated, I'll feed them up the same path as the
>> other changes.
>
> ACK 1-2, though I would consider closely patch #2, whether you need 
> disable_irq() or spin_lock_irqsave() -- which is best for your specific 
> driver + platform?

I'm tempted to leave the disable/enable_irq() in there. It's certainly
heavier than doing cpu-side irq masking, but adding a spinlock to the
common interrupt path seems worse to me. I didn't think we considered
the polling to be a hot path anyway...


-Olof
