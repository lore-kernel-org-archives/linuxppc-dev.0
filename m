Message-ID: <3FC76CEA.9040309@embeddededge.com>
Date: Fri, 28 Nov 2003 10:42:34 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jaap-Jan Boor <jjboor@aimsys.nl>
Cc: Juergen Oberhofer <e9826367@student.tuwien.ac.at>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc / linux kernel - user space
References: <Pine.GHP.4.58.0311271703390.25225@stud3.tuwien.ac.at>	 <7E0B03AE-2100-11D8-BF18-003065E2BB06@aimsys.nl>	 <Pine.GHP.4.58.0311271903490.4360@stud3.tuwien.ac.at> <1070011018.1263.27.camel@linpc003.aimsys.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jaap-Jan Boor wrote:

> If you want to send a signal to user code, you can use kill_proc()
> I think.

IMHO, trying to use signals to propagate a hardware interrupt to a
user application is complicated and has design flaws (what happens
if the application "misses" an interrupt or gets blocked for some
reason).

A couple of other methods that I find simple and use extensively
are multi-threading the application and then using a different
minor ID device to wait on a read() or ioctl() to simply return.
The driver just uses the standard sleep/wakeup mechanisms to
synchronize with the application.

Another, and I think most useful, method is to implement a select/poll
entry point in the driver.  It provides the most flexibility when
waiting for various events, plus provides a timeout should something
fail to function properly.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
