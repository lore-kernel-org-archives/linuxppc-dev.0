Message-ID: <3FC65067.4060900@kegel.com>
Date: Thu, 27 Nov 2003 11:28:39 -0800
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: Juergen Oberhofer <e9826367@student.tuwien.ac.at>
Cc: Jaap-Jan Boor <jjboor@aimsys.nl>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: mpc / linux kernel - user space
References: <Pine.GHP.4.58.0311271703390.25225@stud3.tuwien.ac.at> <7E0B03AE-2100-11D8-BF18-003065E2BB06@aimsys.nl> <Pine.GHP.4.58.0311271903490.4360@stud3.tuwien.ac.at>
In-Reply-To: <Pine.GHP.4.58.0311271903490.4360@stud3.tuwien.ac.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Juergen Oberhofer wrote:
>>>My problem is that the module / the interrupt handling function should
>>>execute a procedure defined in the application program. How can I pass
>>>a pointer (which points to that function) from the appl.program to the
>>>module, such that the handler can execute this function every x
>>>milliseconds? I thought to create a procedure in the module that
>>>accepts
>>>a function pointer as argument. But how can I achieve, that this module
>>>procedure is visible to the application program?
 >>> ...
>> That's normally not something you do and I don't know if it's possible.
>> Application code normally communicates with your driver code using
>> system
>> calls (read/write). So either your appl procedure must be part
>> of your module, or you must signal e.g. a user thread the timer
>> interrupt happened, so the thread can execute that code.
>
> Thank you! You mean that the application should install a signal handler
> and the module sends on every interrupt a signal to the application process.

Although you could do it that way, it might be better to use
a unix domain or a netlink socket, and have the kernel module
send a message which the user program reads via the 'read' system call.

For what it's worth, netlink sockets turn out to be pretty
easy to use.  See http://www.cs.auc.dk/~fleury/netkeeper/
for one example.  Most of the complexity in programs that use
netlink are because they're trying to communicate routing
information.  If you just want to send your own messages,
create the netlink socket with type NETLINK_USERSOCK and
don't worry about the fancy stuff.
- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
