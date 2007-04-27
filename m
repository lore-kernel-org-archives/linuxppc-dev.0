Return-Path: <eberhard.stoll@berghof.com>
Received: from mail176.messagelabs.com (mail176.messagelabs.com
	[85.158.138.83]) by ozlabs.org (Postfix) with SMTP id 76137DDF73
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 03:09:28 +1000 (EST)
Message-ID: <46322E3F.8050508@berghof.com>
Date: Fri, 27 Apr 2007 19:09:19 +0200
From: Eberhard Stoll <eberhard.stoll@berghof.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 ethernet communication stops unexpected
References: <462912AC.8090102@berghof.com> <10220160.post@talk.nabble.com>
In-Reply-To: <10220160.post@talk.nabble.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
> I've the same problem by running MPC5200B, but under MQX ...
>   
Did you check/compare already some registers with mine?
Maybe it could be a hint for a hardware problem in the (RevB) processor 
- or a hint for two different drivers which have the same problem :-)
>> This situation is very rare - only a constellation with 6 Controllers 
>> and a special ethernet communication load leads to this fault - in about 
>> one day!
>>     
No more! Now i can reproduce the fault in between 10 to 30 minutes in my 
office!

Try this:
1) Use two mpc5200 boards and a pc which can telnet into the 
controllers. I use 100M
     FullDuplex settings for the link.
2) Now telnet into the controllers and start on all controllers a flood 
ping. E.g:
        # ping -f 10.255.226.70
    on 10.255.226.71 and a
        # ping -f 10.255.226.71
    on 10.255.226.70. So both controllers ping each others. You can 
watch the
    dots in your telnet session.
3) After some minutes (about 10 to 30 minutes) one of the two 
controllers doesn't
     respond any more. It shows a slow blinking rx led, the link is 
still ok, but the
    controller doesn't respond any more. In the telnet session you can see
    running points on the other controller mixed with some 'E's. In the 
telnet
    session on the other controller you see Ethernet is dead.
    =====================================================
    Congretulations, now you have reproduced the fault!
    =====================================================

It seems that this fault only occurs if the ping is done thru a telnet 
session. Logging into the controller on the serial console and doing the 
pings won't trigger the fault (at least not so fast). This might be a 
timing issue or has to do with Ethernet utilisation. ping -f prints some 
points for transmitted ethernet frames. In case of a telnet session ping 
produces 2 packets at the same time. One for the ping and another for 
the dot in telnet!
If i do a 'ping -f 10.255.226.71 > /dev/null', which suppresses the 
output now run for hours ...

Eberhard

______________________________________________________________________
This email has been scanned by the MessageLabs Email Security System.
For more information please visit http://www.messagelabs.com/email 
______________________________________________________________________
