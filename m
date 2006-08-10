Return-Path: <bwarren@qstreams.com>
Received: from smtp105.biz.mail.re2.yahoo.com (smtp105.biz.mail.re2.yahoo.com
	[206.190.52.174]) by ozlabs.org (Postfix) with SMTP id DC37A67B7E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 05:28:02 +1000 (EST)
Subject: Re: Debugging with no serial port
From: Ben Warren <bwarren@qstreams.com>
To: "Martin, Tim" <tim.martin@viasat.com>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE487105FD10D3@VCAEXCH01.hq.corp.viasat.com>
References: <821B2170E9E7F04FA38DF7EC21DE487105FD10D3@VCAEXCH01.hq.corp.viasat.com>
Content-Type: multipart/alternative; boundary="=-jsspxpk94SfiVzi8Gk5s"
Date: Thu, 10 Aug 2006 15:27:58 -0400
Message-Id: <1155238078.920.15.camel@saruman.qstreams.net>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-jsspxpk94SfiVzi8Gk5s
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Tim,

How about something a bit simpler like running gdb within a 'script'
context, which will log your session to a file.  Get gdb to print the
variables to the screen (using 'print' or whatever), wrap your data with
easily searchable characters (eg. ***data1 data2 data3***), then filter
your data from the script file with sed/awk or perl scripts?

A bit brute force, but bound to work.

regards,
Ben

On Thu, 2006-08-10 at 10:14 -0700, Martin, Tim wrote:
> This may be more of a question for GDB folks...but I'll post it here
> because it relates to embedded systems as well.
>  
> I'm trying to validate some signal processing software on an embedded
> Virtex4 PowerPC 405.  Basically, the validation consists of calling
> functions and looking at their outputs.  Over time, there are several
> thousand numbers to look at, so manually looking at each number at a
> break point would be very time consuming (to put it mildly).
>  
> The normal way I would go about doing this is to print out the data
> (e.g. to a serial port) and post-process the data somewhere else.  But
> on this particular target, I don't have a serial port.  So I thought
> about using GDB's breakpoint command list feature.  When the software
> has data it wants to print out, it calls a function "log_stuff".  I
> then set a breakpoint and command list in the "log_stuff" function,
> which writes out the variables I'm interested in checking out to a
> file named outputfile.bin.  E.g. the following command file does this:
>  
> break log_stuff
> commands
>    silent
>    if (variable_logging_enabled)
>       append value outputfile.bin stuff1_variable
>       append value outputfile.bin stuff2_variable
>    end
>    cont
> end
>  
> The problem I have with this approach is that GDB doesn't finish
> writing out everything before it continues executing the program, so a
> backlog develops.  So my first question would be, is there some GDB
> "flush" like command I could run before the cont statement?
>  
> Second question would be - is there an easier way to accomplish what
> I'm trying to do, which is basically emulate a serial port with GDB.
>  
> Tim
>  
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--=-jsspxpk94SfiVzi8Gk5s
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.10.3">
</HEAD>
<BODY>
Tim,<BR>
<BR>
How about something a bit simpler like running gdb within a 'script' context, which will log your session to a file.&nbsp; Get gdb to print the variables to the screen (using 'print' or whatever), wrap your data with easily searchable characters (eg. ***data1 data2 data3***), then filter your data from the script file with sed/awk or perl scripts?<BR>
<BR>
A bit brute force, but bound to work.<BR>
<BR>
regards,<BR>
Ben<BR>
<BR>
On Thu, 2006-08-10 at 10:14 -0700, Martin, Tim wrote:
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#0000ff">This may be more of a question for GDB folks...but I'll post it here because it relates to embedded systems as well.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#0000ff">I'm trying to validate some signal processing software on an embedded Virtex4 PowerPC 405.&nbsp; Basically, the validation consists of calling functions and looking at their outputs.&nbsp; Over time, there are several thousand numbers to look at, so manually looking at each number at a break point would be very time consuming (to put it mildly).</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#0000ff">The normal way I would go about doing this is to print out the data (e.g. to a serial port) and post-process the data somewhere else.&nbsp; But on this particular target, I don't have a serial port.&nbsp; So I thought about using GDB's breakpoint command list feature.&nbsp; When the software has data it wants to print out, it calls a function &quot;log_stuff&quot;.&nbsp; I then set a breakpoint and command list in the &quot;log_stuff&quot; function, which writes out the variables I'm interested in checking out to a file named outputfile.bin.&nbsp; E.g. the&nbsp;following command file does this:</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">break log_stuff</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">commands</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp; silent</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp; if (variable_logging_enabled)</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; append value outputfile.bin stuff1_variable</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; append value outputfile.bin stuff2_variable</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp; end</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp; cont</FONT></FONT><BR>
    <FONT SIZE="2"><FONT COLOR="#000000">end</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#0000ff">The problem I have with this approach is that GDB doesn't finish writing out everything before it continues executing the program, so a backlog develops.&nbsp; So my first question would be, is there some GDB &quot;flush&quot; like command I could run before the cont statement?</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#0000ff">Second question would be - is there an easier way to accomplish what I'm trying to do, which is basically emulate a serial port with GDB.</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#0000ff">Tim</FONT></FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <FONT COLOR="#000000">&nbsp;</FONT>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
<PRE>
<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Linuxppc-embedded mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</A></FONT>
<FONT COLOR="#000000"><A HREF="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A></FONT>
</PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-jsspxpk94SfiVzi8Gk5s--
