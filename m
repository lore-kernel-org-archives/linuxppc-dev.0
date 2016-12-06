Return-Path: <alexander.stein@systec-electronic.com>
Received: from webbox1416.server-home.net (webbox1416.server-home.net
 [77.236.96.61])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tXtjS4GdSzDvkb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 18:36:27 +1100 (AEDT)
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: Timur Tabi <timur@tabi.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/1] serial/uuc_uart: Set shutdown timeout to CONFIG_HZ
 independent 2ms
Date: Tue, 06 Dec 2016 08:36:22 +0100
Message-ID: <18303458.zhjk47K7B1@ws-stein>
In-Reply-To: <5845900B.5010108@tabi.org>
References: <1480953058-4958-1-git-send-email-alexander.stein@systec-electronic.com>
 <5845900B.5010108@tabi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 05 December 2016 10:04:27, Timur Tabi wrote:
> Alexander Stein wrote:
> > -		schedule_timeout(2);
> > +		schedule_timeout(msecs_to_jiffies(2));
> 
> NACK.
> 
> So I don't remember why I wrote this code, but I don't think I was
> expecting it to be 2ms.  Instead, I think I just wanted it to be some
> delay, but I believed that schedule_timeout(1) was too short or would be
> "optimized" out somehow.
> 
> Note that right below this, I do:
> 
> 	if (qe_port->wait_closing) {
> 		/* Wait a bit longer */
> 		set_current_state(TASK_UNINTERRUPTIBLE);
> 		schedule_timeout(qe_port->wait_closing);
> 	}
> 
> And wait_closing is a number of jiffies, so I knew that
> schedule_timeout() took jiffies as a parameter.
> 
> So I think I'm going to NACK this patch, since I believe I knew what I
> was doing when I wrote it five years ago.

Okay, I was just wondering why the timeout is dependant on the timer tick. 
That didn't seem obvious to me.
Rethinking about this, I would rather replace those lines with msleep instead.

Best regards,
Alexander
