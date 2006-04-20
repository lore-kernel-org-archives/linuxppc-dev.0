Return-Path: <rsa@us.ibm.com>
Subject: question on why hvc_console calls hvc_poll() in
	hvc_handle_interrupt().
From: Ryan Arnold <rsa@us.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <1145563391.29313.174.camel@localhost.localdomain>
References: <20060418185534.B1ADF679F0@ozlabs.org>
	<1145563391.29313.174.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 15:25:52 -0500
Message-Id: <1145564752.29313.185.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While on the topic of hvc_console; I think I saw a patch go through a
while ago that added hvc_poll() to hvc_handle_interrupt().  I can't say
I'm too pleased with that addition.  I did my best to keep locking
outside of the interrupt handler.

I wonder if that change was tested on a power5 lpar system with several
secondary VSerial Server adapters (hvc1-hvcn) being hammered with data.
I'm pretty paranoid about deadlock, hence the reason for keeping locking
out of the int. handler.
-- 
Ryan S. Arnold <rsa@us.ibm.com>
IBM Linux Technology Center
Linux on Power Toolchain
