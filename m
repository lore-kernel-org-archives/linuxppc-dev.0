To: "rick.liu" <dovi@eyou.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: kermit:How to disable the flow control signals? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "17 May 2003 13:18:24 +0800."
             <20030517131824.39906.qmail@eyou.com>
Date: Sat, 17 May 2003 09:29:45 +0200
Message-Id: <20030517072950.68F81C6092@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030517131824.39906.qmail@eyou.com> you wrote:
>
>     I installed c-kermit209 in my linux,and copy the dot.kermrc
> in the u-boot0.3.0 to ~/.kermrc,then connect the kermit to my direct
> -serral port:
...
> here is the question:
> 1.why the flow control signals are still "on"?

Because this is what you serial  driver  reports  about  the  current
state of these pins?

> 2.if I have a 3-wired smc1/serial port,how to configure
>   to turn off RTS/CTS etc.?

You already did. The relevant lines from the ~/.kermrc file are:

	set carrier-watch off
	set handshake none
	set flow-control none

To verify, type "show comm" at the kermit prompt:

	Kermit>show comm

	Communications Parameters:
	 Line: /dev/ttyS1, speed: 115200, mode: local, modem: generic
	 Parity: none, stop-bits: (default) (8N1)
	 Duplex: full, flow: none, handshake: none
	 Carrier-watch: off, close-on-disconnect: off
	 Lockfile: /var/lock/LCK..ttyS1
	 Terminal bytesize: 8, escape character: 28 (^\)

The relevant part here is the "flow: none", "handshake: none" and
"Carrier-watch: off" entries.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Life. Don't talk to me about life.      - Marvin the Paranoid Android

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
