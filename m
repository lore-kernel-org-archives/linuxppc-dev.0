To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: egcs-patches@egcs.cygnus.com, rth@cygnus.com, meissner@cygnus.com,
        David Edelsohn <dje@watson.ibm.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: PATCH: Fix 2 PPC/SYSV varargs problems 
Reply-To: law@cygnus.com
In-reply-to: Your message of Fri, 30 Apr 1999 02:09:09 +0200.
             <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com>
Date: Wed, 12 May 1999 00:19:53 -0600
Message-ID: <6498.926489993@upchuck.cygnus.com>
From: Jeffrey A Law <law@upchuck.cygnus.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


  In message <4.2.0.37.19990430013458.0489a950@mail.lauterbach.com>you write:
  > --=====================_53744284==_
  > Content-Type: text/plain; charset="us-ascii"; format=flowed
  > 
  > Hi,
  > 
  > this patch is supposed to fix the following problems on PPC/SYSV:
  > 
  > 1. the varargs save area calculation bug, this is a hack and Richard ;-) 
  > probably won't like it, but maybe it's good enough for egcs-1.2
  > 
  > 2. if you call a function that uses more then 8 float args before all 
  > integer argument passing registers are consumed, egcs will missetup the 
  > calling sequence. I introduced a new variable cum->sysv_fwords in the 
  > CUMULATIVE_ARGS struct, which counts the saved float words and adjusted 
  > cum->words where needed (I hope). There maybe better/nicer ways to 
  > implement that, so tell me if you want a different solution. A testcase is 
  > attached, the original problem happens with gnuplot.
Has this problem been fixed?  I see patch from Richard which looks like it
is related:

       * va-ppc.h (__va_start_common): Let __builtin_saveregs do the work.
        * rs6000.c (expand_builtin_saveregs): For V4, initialize a private
        va_list struct, and return a pointer to it.
        (setup_incoming_varargs): V4 save area based off virtual_stack_vars
        instead of frame_pointer.

[ yes, I'm going through my backlog now trying to weed out issues that I
  don't need to deal with :-) ]

jeff

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
