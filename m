Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXV9N27Z2zDqcf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 03:10:48 +1100 (AEDT)
Subject: Re: [PATCH 1/1] serial/uuc_uart: Set shutdown timeout to CONFIG_HZ
 independent 2ms
To: Alexander Stein <alexander.stein@systec-electronic.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org
References: <1480953058-4958-1-git-send-email-alexander.stein@systec-electronic.com>
From: Timur Tabi <timur@tabi.org>
Message-ID: <5845900B.5010108@tabi.org>
Date: Mon, 5 Dec 2016 10:04:27 -0600
MIME-Version: 1.0
In-Reply-To: <1480953058-4958-1-git-send-email-alexander.stein@systec-electronic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Stein wrote:
> -		schedule_timeout(2);
> +		schedule_timeout(msecs_to_jiffies(2));

NACK.

So I don't remember why I wrote this code, but I don't think I was 
expecting it to be 2ms.  Instead, I think I just wanted it to be some 
delay, but I believed that schedule_timeout(1) was too short or would be 
"optimized" out somehow.

Note that right below this, I do:

	if (qe_port->wait_closing) {
		/* Wait a bit longer */
		set_current_state(TASK_UNINTERRUPTIBLE);
		schedule_timeout(qe_port->wait_closing);
	}

And wait_closing is a number of jiffies, so I knew that 
schedule_timeout() took jiffies as a parameter.

So I think I'm going to NACK this patch, since I believe I knew what I 
was doing when I wrote it five years ago.
