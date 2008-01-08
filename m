Return-Path: <galak@kernel.crashing.org>
Message-Id: <E031E6FD-8A6F-49D5-9241-33B6ADEECCF7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
In-Reply-To: <20080108052743.GA18083@windriver.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH/RFC] mpc83xx/85xx SysRQ/brk over 8250 console
Date: Tue, 8 Jan 2008 00:11:19 -0600
References: <20080108052743.GA18083@windriver.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 7, 2008, at 11:27 PM, Paul Gortmaker wrote:

> It seems that if a break is rec'd on the serial console (as per SysRQ
> or similar) on some 83xx and 85xx processors, then a pulse of IRQs is
> generated which makes the use of SysRQ itself about 99% impossible.  I
> experimented with trying several ACK strategies, but in the end the
> thing which worked best was just to wait for the surge of events to  
> pass
> (a fraction of a second).  The number of events can be on the order of
> 1000 (as reported by /proc/interrupts)
>
> I really dislike seeing board specific ifdefs within what should be
> board independent code, so I'm hoping that once the problem is known,
> that a more elegant solution will pop into someone's head.  Or at  
> least
> this will hopefully save someone the grief of re-investigating the  
> source
> and start a discussion.
>
> I've seen this on two different 834x boards and also an 8548 based
> board.  At this point, it is not clear to me if the problem extends
> beyond these CPU/soc to all with UARTs at 4500/4600.
>
> While less than ideal, the work-around below which simply ignores the
> events does allow a person to use SysRQ on such platforms.
>
> The definition of the RFE bit (Rx FIFO error) can be found in pretty
> much any of the MPC CPU PDFs (for those with 4500/4600 16550s).
>
> Paul.

This should really get posted to linux-kernel@vger.kernel.org and  
probably linux-serial@vger.kernel.org lists.

- k
