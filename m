Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17485.23369.946413.882252@cargo.ozlabs.ibm.com>
Date: Tue, 25 Apr 2006 09:12:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Subject: Re: alignment exceptionhandler sleeps in invalid context
In-Reply-To: <20060424173246.GA22318@suse.de>
References: <20060424173246.GA22318@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> I'm not sure where the bug is. Does it mean the network stack does
> something nasty, or is the exception handler itself broken? (probably the latter)
> This is 2.6.16.9 on a p270.

The alignment handler does a get_user to read the instruction.  I
suppose it will have to read the instruction directly if the exception
occurred in kernel mode.

Paul.
