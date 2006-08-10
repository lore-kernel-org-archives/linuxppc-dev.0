Return-Path: <tim.martin@viasat.com>
Received: from VCAEXCH02.hq.corp.viasat.com (kestrel.viasat.com
	[199.106.52.139]) by ozlabs.org (Postfix) with ESMTP id 80F8A67B5F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Aug 2006 06:12:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Debugging with no serial port
Date: Thu, 10 Aug 2006 13:12:47 -0700
Message-ID: <821B2170E9E7F04FA38DF7EC21DE487105FD14A0@VCAEXCH01.hq.corp.viasat.com>
From: "Martin, Tim" <tim.martin@viasat.com>
To: <bwarren@qstreams.com>
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

Ben,

>	How about something a bit simpler like running gdb within a
'script' context,
> which will log your session to a file.  Get gdb to print the variables
to the screen
> (using 'print' or whatever), wrap your data with easily searchable
characters=20
> (eg. ***data1 data2 data3***), then filter your data from the script
file with sed/awk
> or perl scripts?
=09
I tried this as well and have the same GDB synchronization problem e.g.

break log_stuff
commands
   silent
   if (variable_logging_enabled)
      printf "(%d,%d)\n",stuff1_variable,stuff2_variable
   end
   cont
end

The printf's don't complete before the cont happens.  Sounds like maybe
this is a GDB problem...

Tim
=09
