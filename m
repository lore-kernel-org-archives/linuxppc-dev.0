Return-Path: <netstv@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.227])
	by ozlabs.org (Postfix) with ESMTP id CA98ADDEC1
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 Apr 2007 04:01:02 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so933973wxd
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 01 Apr 2007 11:00:59 -0700 (PDT)
Message-ID: <b4b98b690704011100j146fae9ap289b210caa6940f3@mail.gmail.com>
Date: Sun, 1 Apr 2007 11:00:58 -0700
From: "Steve Iribarne (GMail)" <netstv@gmail.com>
To: "Charles Krinke" <ckrinke@istor.com>
Subject: Re: PPC login puzzle
In-Reply-To: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6D@MERCURY.inside.istor.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_98030_12037724.1175450458053"
References: <20070329192932.98FBD353A6C@atlas.denx.de>
	<200703291345.35978.tmaenner@aehr.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6B@MERCURY.inside.istor.com>
	<460DDB1F.7020106@billgatliff.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6C@MERCURY.inside.istor.com>
	<b4b98b690703310920k63a60835s8d3ba6993d72179d@mail.gmail.com>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B6D@MERCURY.inside.istor.com>
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

------=_Part_98030_12037724.1175450458053
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 3/31/07, Charles Krinke <ckrinke@istor.com> wrote:
>
> Seems to me thing you can do is find out why the telnet session is being
> rejected.  Have you done an ethernet capture?
>
> <snip....>
> It is interesting that 'telnet localhost' fails in a similar way as telnet
> across the



Ok.. This tells me it's a telnet problem.  So either the telentd isn't
starting up properly on this system OR there is some weird rights thing that
you have setup differently on both systems.

Are you using anything like busybox?  Which telnet are you using.  It's
killing me because I know I have run into this same problem.  But I am old
and I forgot what I did.  I had this problem about 3 years ago.. ugh.

To me it was something with securetty or the like.  There is a config file
that allows telnet or not.  Another thing to try is to load telnetd with
more options.  I think there is "-a debug" you can turn on and that will
turn on the authentication debugging... "-D report" should also help you
out.

I'm sure it has something to do with root not being able to logon or maybe
it's the blank password.  Create a password for root and see if that helps.

-stv


network, and I appreciate your kind hints, especially about the log file and
> /var/log/syslog helps a bit on this problem.
>
> When trying to telnet accross the network, syslog says
>
> in.telnetd[]: connect from x.x.x.x
>
> But entering root doesnt work and the host then says:
> sff1 login: root
> Login incorrect
>
> There are no further errors on the 8541. When trying to 'telnet
> localhost', syslog says
>
> in.telnetd[]: connect from 127.0.0.1
>
> But neither completes the login, so although there is a clue here, the
> logical path to conclusion is still escaping me a little bit.
>
> I can see that both targets have the same /etc/xinted.d/telnet file and it
> contains:
>
> service telnet
> {
> flags  = REUSE
> socket_type = stream
> protocol = tcp
> wait  = no
> user  = root
> server  = /usr/sbin/in.telnetd
> server_args = -h
> log_on_failure += USERID
> }
>
> which I think is reasonable in this situation. So, this begs the question
> of what other things still bear on this type of problem. Again, I appreciate
> your taking the time to help me understand a bit more of how this fits
> together.
>
> Charles
>
>
>


-- 
/*
* Steve Iribarne
* Software Engineer
* (aka Grunt)
*/

------=_Part_98030_12037724.1175450458053
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 3/31/07, <b class="gmail_sendername">Charles Krinke</b> &lt;<a href="mailto:ckrinke@istor.com">ckrinke@istor.com</a>&gt; wrote:<div><span class="gmail_quote"></span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Seems to me thing you can do is find out why the telnet session is being rejected.&nbsp;&nbsp;Have you done an ethernet capture?<br><br>&lt;snip....&gt;<br>It is interesting that &#39;telnet localhost&#39; fails in a similar way as telnet across the 
</blockquote><div><br><br>Ok.. This tells me it&#39;s a telnet problem.&nbsp; So either the telentd isn&#39;t starting up properly on this system OR there is some weird rights thing that you have setup differently on both systems.
<br><br>Are you using anything like busybox?&nbsp; Which telnet are you using.&nbsp; It&#39;s killing me because I know I have run into this same problem.&nbsp; But I am old and I forgot what I did.&nbsp; I had this problem about 3 years ago.. ugh. 
<br><br>To me it was something with securetty or the like.&nbsp; There is a config file that allows telnet or not.&nbsp; Another thing to try is to load telnetd with more options.&nbsp; I think there is &quot;-a debug&quot; you can turn on and that will turn on the authentication debugging... &quot;-D report&quot; should also help you out.
<br><br>I&#39;m sure it has something to do with root not being able to logon or maybe it&#39;s the blank password.&nbsp; Create a password for root and see if that helps.<br><br>-stv<br>&nbsp;</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
network, and I appreciate your kind hints, especially about the log file and /var/log/syslog helps a bit on this problem.<br><br>When trying to telnet accross the network, syslog says<br><br>in.telnetd[]: connect from x.x.x.x
<br><br>But entering root doesnt work and the host then says:<br>sff1 login: root<br>Login incorrect<br><br>There are no further errors on the 8541. When trying to &#39;telnet localhost&#39;, syslog says<br><br>in.telnetd
[]: connect from <a href="http://127.0.0.1">127.0.0.1</a><br><br>But neither completes the login, so although there is a clue here, the logical path to conclusion is still escaping me a little bit.<br><br>I can see that both targets have the same /etc/xinted.d/telnet file and it contains:
<br><br>service telnet<br>{<br> flags&nbsp;&nbsp;= REUSE<br> socket_type = stream<br> protocol = tcp<br> wait&nbsp;&nbsp;= no<br> user&nbsp;&nbsp;= root<br> server&nbsp;&nbsp;= /usr/sbin/in.telnetd<br> server_args = -h<br> log_on_failure += USERID<br>}<br><br>which I think is reasonable in this situation. So, this begs the question of what other things still bear on this type of problem. Again, I appreciate your taking the time to help me understand a bit more of how this fits together.
<br><br>Charles<br><br><br></blockquote></div><br><br clear="all"><br>-- <br>/*<br> * Steve Iribarne<br> * Software Engineer<br> * (aka Grunt) <br> */

------=_Part_98030_12037724.1175450458053--
