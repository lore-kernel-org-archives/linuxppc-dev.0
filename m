Subject: Re: mpc / linux kernel - user space
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Dan Malek <dan@embeddededge.com>
Cc: Juergen Oberhofer <e9826367@student.tuwien.ac.at>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <3FC76CEA.9040309@embeddededge.com>
References: <Pine.GHP.4.58.0311271703390.25225@stud3.tuwien.ac.at>
	 <7E0B03AE-2100-11D8-BF18-003065E2BB06@aimsys.nl>
	 <Pine.GHP.4.58.0311271903490.4360@stud3.tuwien.ac.at>
	 <1070011018.1263.27.camel@linpc003.aimsys.nl>
	 <3FC76CEA.9040309@embeddededge.com>
Content-Type: text/plain
Message-Id: <1070266735.328.5.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Mon, 01 Dec 2003 09:18:55 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-11-28 at 16:42, Dan Malek wrote:
> Jaap-Jan Boor wrote:
>
> > If you want to send a signal to user code, you can use kill_proc()
> > I think.
>
> IMHO, trying to use signals to propagate a hardware interrupt to a
> user application is complicated and has design flaws (what happens
> if the application "misses" an interrupt or gets blocked for some
> reason).

Fortunately I never used it (that's the 'I think')

>
> A couple of other methods that I find simple and use extensively
> are multi-threading the application and then using a different
> minor ID device to wait on a read() or ioctl() to simply return.
> The driver just uses the standard sleep/wakeup mechanisms to
> synchronize with the application.
>
> Another, and I think most useful, method is to implement a select/poll
> entry point in the driver.  It provides the most flexibility when
> waiting for various events, plus provides a timeout should something
> fail to function properly.

Yes, especially the timeout is nice as 'this should never happen'
failures never happens except with the customer

Jaap-Jan

>
>
> 	-- Dan
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
