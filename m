Date: Mon, 23 Aug 1999 11:42:11 -0400
From: Michael Meissner <meissner@cygnus.com>
To: David Edelsohn <dje@watson.ibm.com>
Cc: trevor@ica.net, LinuxPPC dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: creating EABI stack frames
Message-ID: <19990823114211.A22875@tiktok.cygnus.com>
References: <trevor@ica.net> <9907301512.AA32890@marc.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9907301512.AA32890@marc.watson.ibm.com>; from David Edelsohn on Fri, Jul 30, 1999 at 11:12:36AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Jul 30, 1999 at 11:12:36AM -0400, David Edelsohn wrote:
> 
> 	Linux/PPC uses SVR4 ABI for PowerPC.  Linux/PPC originally was
> developed using eABI which is a more restrictive variant of SVR4, but it
> has transitioned to standard SVR4.  SVR4 and eABI stacks look identical.

ABI mandates that the stack frame be aligned to a 16 byte boundary, while eABI
mandates an 8 byte boundary.  Other differences include eABi having 2 small
data pointers (r2 and r13), while ABI just has one (r13, r2 is reserved), some
relocs are in eABI and not in ABI (and vica versa).  Finally under eABI, gcc
calls __eabi in main to initialize things.

> 	For a description of the stack frame, see the file
> gcc/config/rs6000.c in the GCC distribution.  Just above the function
> rs6000_stack_info() is a picture, like the ones in your message, showing
> the layout of an AIX, SVR4, and Windows/NT (discontinued) stack on
> PowerPC. 
> 
> 	The current release of GCC does have some argument alignment
> problems and stdarg/varargs is very complicated for SVR4/PPC.  The
> alignment problems may be fixed in gcc-2.95.1, but I cannot guarantee
> that. 
> 
> David
> 
> 

-- 
Michael Meissner, Cygnus Solutions
PMB 198, 174 Littleton Road #3, Westford, Massachusetts 01886
email: meissner@cygnus.com	phone: 978-486-9304	fax: 978-692-4482

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
