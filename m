Return-Path: <kalyan.alle@gmail.com>
Received: from mail-qy0-f189.google.com (mail-qy0-f189.google.com
	[209.85.221.189]) by ozlabs.org (Postfix) with ESMTP id EAC28B7D0A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Apr 2010 17:07:35 +1000 (EST)
Received: by qyk27 with SMTP id 27so2528114qyk.23
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 08 Apr 2010 00:07:33 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 8 Apr 2010 12:37:33 +0530
Message-ID: <t2i42409cb31004080007u1b06d3f3rc2f180cf2d956428@mail.gmail.com>
Subject: Netdev watchdog timed out on gianfar ethernet driver
From: kalyan Alle <kalyan.alle@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, kalyan Alle <kalyan.alle@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi ,
We are using gianfar ethernet driver in our device (2.6.20 kernel).  I
have observed the following error after i run high throughput traffic
for some time.

NETDEV WATCHDOG: eth0: transmit timed out

The Kernel we are using is 2.6.20 kernel.  I have added the work queue
support in the gfar_timeout  (which was not there in the 2.6.20 )
,which was given in the later kernels  from 2.6.27.
Without the work queue support i observed the crash. More precisely
the crash is fixed with the work queue effort ,but still i could see
the
NETDEV WATCHDOG: eth0: transmit timed out  .  which stops the end to
end traffic flow in few seconds after the bidirectional traffic is
pumped.

I have given "ifconfig eth0 down" when this happend and then "ifconfig eth0 up"
The interface down and up seems to have brought the eht0 into active
state and traffic continued to run.

Can any bidy suggest a clue as how to fix the NETDEV WATCHDOG: eth0:
transmit timed out issue.

thanks
kalyan alle
