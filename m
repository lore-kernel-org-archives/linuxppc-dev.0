Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17506.31527.114193.218433@cargo.ozlabs.ibm.com>
Date: Thu, 11 May 2006 09:45:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Wilder <dwilder@us.ibm.com>
Subject: Re: [RFC-PATCH] Prevent tasks from sleeping in die()
In-Reply-To: <44628316.80600@us.ibm.com>
References: <44628316.80600@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Wilder writes:

> I am seeing an issue in die() when voluntary preemption is enabled.
> die() 
> ->>show_regs()->>show_instructions()->>__get_user_nocheck()->>might_sleep()

Are you using Linus' current git tree?  It has a patch that fixes this
problem by making __get_user_nocheck do the might_sleep only if the
address you give it is a user address.

Paul.
