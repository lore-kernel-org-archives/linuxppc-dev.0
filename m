Date: Mon, 27 Mar 2000 11:25:18 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: David Edelsohn <dje@watson.ibm.com>
cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
        Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet 
In-Reply-To: <200003271913.OAA28080@mal-ach.watson.ibm.com>
Message-ID: <Pine.LNX.4.10.10003271120040.10719-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Can anybody explain how method a) is different/better then method b) ?
I *lot* of drivers are using method b) so is that to say all the
developers who are using it are wrong and should change?


a) asm volatile ("stwbrx %1,%2,%3; eieio"
          : "=m" (*(volatile unsigned *)(base_addr+regindex))
          : "r" (regdata), "b" (regindex), "r" (base_addr));


b) asm volatile ("stwbrx %0,%1,%2; eieio" : : "r"(regdata), "b"
		 (regindex), "r"(base_addr) : "memory");



a) asm volatile ("lwbrx %0,%1,%2; eieio"
           : "=r"(val)
           : "b"(regindex), "r"(base_addr),
             "m" (*(volatile unsigned *)(base_addr+regindex)));

b) asm volatile ("lwbrx %0,%1,%2; eieio" : "=r"(val) : "b"(regindex),
		  "r"(base_addr));


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
