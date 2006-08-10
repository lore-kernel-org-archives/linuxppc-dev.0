Return-Path: <frannk_m1@yahoo.com>
Received: from web32203.mail.mud.yahoo.com (web32203.mail.mud.yahoo.com
	[68.142.207.134]) by ozlabs.org (Postfix) with SMTP id 709BA67B76
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 03:31:33 +1000 (EST)
Message-ID: <20060810173131.68301.qmail@web32203.mail.mud.yahoo.com>
Date: Thu, 10 Aug 2006 10:31:31 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
Subject: Re: Debugging with no serial port
To: "Martin, Tim" <tim.martin@viasat.com>, linuxppc-embedded@ozlabs.org
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE487105FD10D3@VCAEXCH01.hq.corp.viasat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



--- "Martin, Tim" <tim.martin@viasat.com> wrote:

> This may be more of a question for GDB folks...but I'll post
> it here
> because it relates to embedded systems as well.
>  
> I'm trying to validate some signal processing software on an
> embedded
> Virtex4 PowerPC 405.  Basically, the validation consists of
> calling
> functions and looking at their outputs.  Over time, there are
> several
> thousand numbers to look at, so manually looking at each
> number at a
> break point would be very time consuming (to put it mildly).
>  
> The normal way I would go about doing this is to print out the
> data
> (e.g. to a serial port) and post-process the data somewhere
> else.  But
> on this particular target, I don't have a serial port.  So I
> thought
> about using GDB's breakpoint command list feature.  When the
> software
> has data it wants to print out, it calls a function
> "log_stuff".  I then
> set a breakpoint and command list in the "log_stuff" function,
> which
> writes out the variables I'm interested in checking out to a
> file named
> outputfile.bin.  E.g. the following command file does this:
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
> The problem I have with this approach is that GDB doesn't
> finish writing
> out everything before it continues executing the program, so a
> backlog
> develops.  So my first question would be, is there some GDB
> "flush" like
> command I could run before the cont statement?
>  
> Second question would be - is there an easier way to
> accomplish what I'm
> trying to do, which is basically emulate a serial port with
> GDB.
>  
> Tim

Use NetConsole or remotey log it with syslog...

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
