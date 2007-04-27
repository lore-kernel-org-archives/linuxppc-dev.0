Return-Path: <david.kanceruk@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.241])
	by ozlabs.org (Postfix) with ESMTP id 99A16DDF77
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 03:22:30 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b21so827721ana
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 10:22:29 -0700 (PDT)
Message-ID: <5b525e390704271022x599e5504g4f31df9c01965010@mail.gmail.com>
Date: Fri, 27 Apr 2007 12:22:28 -0500
From: "David Kanceruk" <david.kanceruk@gmail.com>
To: "Eberhard Stoll" <eberhard.stoll@berghof.com>
Subject: Re: MPC5200 ethernet communication stops unexpected
In-Reply-To: <46322E3F.8050508@berghof.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_368042_7277862.1177694548794"
References: <462912AC.8090102@berghof.com> <10220160.post@talk.nabble.com>
	<46322E3F.8050508@berghof.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_368042_7277862.1177694548794
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

     Do your boards use the MPC5200B or MPC5200? Also, do you ever see any
corrupted data? (I'm guessing you would have mentioned it if you did see
corrupted data)

Regards,

Dave

On 4/27/07, Eberhard Stoll <eberhard.stoll@berghof.com> wrote:
>
> Hi,
> > I've the same problem by running MPC5200B, but under MQX ...
> >
> Did you check/compare already some registers with mine?
> Maybe it could be a hint for a hardware problem in the (RevB) processor
> - or a hint for two different drivers which have the same problem :-)
> >> This situation is very rare - only a constellation with 6 Controllers
> >> and a special ethernet communication load leads to this fault - in
> about
> >> one day!
> >>
> No more! Now i can reproduce the fault in between 10 to 30 minutes in my
> office!
>
> Try this:
> 1) Use two mpc5200 boards and a pc which can telnet into the
> controllers. I use 100M
>      FullDuplex settings for the link.
> 2) Now telnet into the controllers and start on all controllers a flood
> ping. E.g:
>         # ping -f 10.255.226.70
>     on 10.255.226.71 and a
>         # ping -f 10.255.226.71
>     on 10.255.226.70. So both controllers ping each others. You can
> watch the
>     dots in your telnet session.
> 3) After some minutes (about 10 to 30 minutes) one of the two
> controllers doesn't
>      respond any more. It shows a slow blinking rx led, the link is
> still ok, but the
>     controller doesn't respond any more. In the telnet session you can see
>     running points on the other controller mixed with some 'E's. In the
> telnet
>     session on the other controller you see Ethernet is dead.
>     =====================================================
>     Congretulations, now you have reproduced the fault!
>     =====================================================
>
> It seems that this fault only occurs if the ping is done thru a telnet
> session. Logging into the controller on the serial console and doing the
> pings won't trigger the fault (at least not so fast). This might be a
> timing issue or has to do with Ethernet utilisation. ping -f prints some
> points for transmitted ethernet frames. In case of a telnet session ping
> produces 2 packets at the same time. One for the ping and another for
> the dot in telnet!
> If i do a 'ping -f 10.255.226.71 > /dev/null', which suppresses the
> output now run for hours ...
>
> Eberhard
>
> ______________________________________________________________________
> This email has been scanned by the MessageLabs Email Security System.
> For more information please visit http://www.messagelabs.com/email
> ______________________________________________________________________
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
David Kanceruk

"The generation of random numbers is far too important to be left to
chance."

------=_Part_368042_7277862.1177694548794
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>&nbsp;&nbsp;&nbsp;&nbsp; Do your boards use the MPC5200B or MPC5200? Also, do you ever see any corrupted data? (I&#39;m guessing you would have mentioned it if you did see corrupted data)<br><br>Regards,<br><br>Dave<br><br><div><span class="gmail_quote">
On 4/27/07, <b class="gmail_sendername">Eberhard Stoll</b> &lt;<a href="mailto:eberhard.stoll@berghof.com">eberhard.stoll@berghof.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi,<br>&gt; I&#39;ve the same problem by running MPC5200B, but under MQX ...<br>&gt;<br>Did you check/compare already some registers with mine?<br>Maybe it could be a hint for a hardware problem in the (RevB) processor<br>
- or a hint for two different drivers which have the same problem :-)<br>&gt;&gt; This situation is very rare - only a constellation with 6 Controllers<br>&gt;&gt; and a special ethernet communication load leads to this fault - in about
<br>&gt;&gt; one day!<br>&gt;&gt;<br>No more! Now i can reproduce the fault in between 10 to 30 minutes in my<br>office!<br><br>Try this:<br>1) Use two mpc5200 boards and a pc which can telnet into the<br>controllers. I use 100M
<br>&nbsp;&nbsp;&nbsp;&nbsp; FullDuplex settings for the link.<br>2) Now telnet into the controllers and start on all controllers a flood<br>ping. E.g:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# ping -f <a href="http://10.255.226.70">10.255.226.70</a><br>&nbsp;&nbsp;&nbsp;&nbsp;on <a href="http://10.255.226.71">
10.255.226.71</a> and a<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;# ping -f <a href="http://10.255.226.71">10.255.226.71</a><br>&nbsp;&nbsp;&nbsp;&nbsp;on <a href="http://10.255.226.70">10.255.226.70</a>. So both controllers ping each others. You can<br>watch the<br>&nbsp;&nbsp;&nbsp;&nbsp;dots in your telnet session.
<br>3) After some minutes (about 10 to 30 minutes) one of the two<br>controllers doesn&#39;t<br>&nbsp;&nbsp;&nbsp;&nbsp; respond any more. It shows a slow blinking rx led, the link is<br>still ok, but the<br>&nbsp;&nbsp;&nbsp;&nbsp;controller doesn&#39;t respond any more. In the telnet session you can see
<br>&nbsp;&nbsp;&nbsp;&nbsp;running points on the other controller mixed with some &#39;E&#39;s. In the<br>telnet<br>&nbsp;&nbsp;&nbsp;&nbsp;session on the other controller you see Ethernet is dead.<br>&nbsp;&nbsp;&nbsp;&nbsp;=====================================================<br>
&nbsp;&nbsp;&nbsp;&nbsp;Congretulations, now you have reproduced the fault!<br>&nbsp;&nbsp;&nbsp;&nbsp;=====================================================<br><br>It seems that this fault only occurs if the ping is done thru a telnet<br>session. Logging into the controller on the serial console and doing the
<br>pings won&#39;t trigger the fault (at least not so fast). This might be a<br>timing issue or has to do with Ethernet utilisation. ping -f prints some<br>points for transmitted ethernet frames. In case of a telnet session ping
<br>produces 2 packets at the same time. One for the ping and another for<br>the dot in telnet!<br>If i do a &#39;ping -f <a href="http://10.255.226.71">10.255.226.71</a> &gt; /dev/null&#39;, which suppresses the<br>output now run for hours ...
<br><br>Eberhard<br><br>______________________________________________________________________<br>This email has been scanned by the MessageLabs Email Security System.<br>For more information please visit <a href="http://www.messagelabs.com/email">
http://www.messagelabs.com/email</a><br>______________________________________________________________________<br>_______________________________________________<br>Linuxppc-embedded mailing list<br><a href="mailto:Linuxppc-embedded@ozlabs.org">
Linuxppc-embedded@ozlabs.org</a><br><a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br></blockquote></div><br><br clear="all"><br>-- <br>David Kanceruk
<br><br>&quot;The generation of random numbers is far too important to be left to chance.&quot;

------=_Part_368042_7277862.1177694548794--
