Message-Id: <199909171347.PAA25269@denx.local.net>
To: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Cleanup thought. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Sep 1999 11:01:56 +0200."
             <37E20384.BD066E8C@switchboard.ericsson.se>
Date: Fri, 17 Sep 1999 15:47:14 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <37E20384.BD066E8C@switchboard.ericsson.se> Magnus Damm
wrote:
> 
> I would like to take up the question about configuration again.

Thanks!

> I believe that the situation is the same for a lot of people 
> out here: Get Linux working on some kind of new 8xx hardware.
> 
> Today we need to modify and add #ifdefs to different files.

Right, and it is always  pretty  cumbersome,  because  the  necessary
consfiguration is distributed over a lot of unrelated files.

> I like the idea of some kind of central board specific file.

Or (maybe better) a group of "BSP" (Board Support Package) files.

> I suggested the following code to Dan Malek a while ago, and he didn't 
> like the idea with a lot of inline code in one .h file, right Dan? 
> 
> Anyone else out there with another idea how to solve this problem?

To be honest: I don't like this code much either.

Ok, let's talk about the Motorola MPC8xx family only  (first  because
this is the one I know best, second because that seems to be the most
popular);  maybe someone with better knowledge of other architectures
can help generalizing some ideas:

Let's assume we follow the way some commercial RTOS vendors have gone
and create `BSP's for the different  Linux  configurations:  The  BSP
name would be one option to select in the `make config' process.

* Boot loader:

  The current version of  arch/ppc/mbxboot/head.S  is  aready  pretty
  hard  to  read,  and I found it pretty difficult to add two or more
  new boards. It was simpler for me to use it as a starting point  to
  write my own specialized version.

  I   suggest   to   rename   `head.S'   into    `head_mbx.S',    use
  `head_<BSP-Name>.S'  for  all  systems that are not very similar to
  the ones already supported by `head_mbx.S'. The Makefile would then
  select the right version.

* Hardware initialization: there are probably two parts for this: one
  part during very early system initalization,  before  the  MMU  has
  been turned on, and another one, when the MMU is on.

  Things that would  be  done  in  the  first  group:  disabling  the
  watchdog, initializing other peripherals on the board (for instance
  any slave 68360's :-), ...

  Things  for  the  second  part  of  initialization:  DEC/TB/RTC/PIT
  initialization,  port configuration, mapping of BSP specific memory
  regions (FLASH, SRAM, ...), ...

* Device drivers: we should have a clean way to  configure  how  many
  serial  ports  we have, which port they are on, and what parameters
  to use. Same for Ethernet and  other  drivers.  The  real  code  to
  enable  or  disable  ports  should  be  separated  from the generic
  source, since this is different from BSP to BSP: here  you  have  a
  Board Control Register, there it's just a special port bin, etc.

  For instance, I thing there could be functions used like this:

  bsp_eth_init (DEV_SCC2, CPM_CLK1, CPM_CLK3); /* port, Rx clock, Tx clock */
  bsp_eanble_receiver (DEV_SMC1);
  bsp_disable_transmit (DEV_SCC1);
  etc.

  Basicly this means introducing "logical device names" for the  CPM,
  and  using  these as parameters for generalized functions. The code
  of these functions would be a bit bigger, but a lot can be done  by
  just  shifting  the  corresponding  bits  into the right positions,
  using the "device" number as a shift offset.

* General: wherever we identify parts of the code that depend on  the
  hardware  configuration, we should move this code into a BSP layer.
  Thus we would have generic code (that calls BSP functions), and BSP
  code that needs to be adapted for new hardware.

* Driver configuration: I don't like the idea  of  modifying  generic
  source  files  just  to  add  or  remove  a  serial  port  from the
  configuration. We could define some generic parameter structures to
  be used by the drivers, that just need to be filled out.

  Example 1 - serial port configuration:

  	typedef struct tty_info_s {
		int	device;
		int	clock;
		int	speed;
		... more parameters if needed (for instance line mode
		settings, erase character, ...)
	} tty_info_t;

  Then all that's needed to configure serial ports on SMC2  and  SCC1
  would be:

  tty_info_t tty_configuration[] = {
  	{ DEV_SMC2, CPM_BRG2, B115200); },
	{ DEV_SCC1, CPM_BRG1, B9600);	},
  };

  Example 2: same for Ethernet; here we would problably configure the
  device, the Rx and Tx clock sources, and maybe the number  of  BD's
  used for this port:

  eth_info_t eth_configuration[] = {
  	{ DEV_SCC2, CPM_CLK1, CPM_CLK3, 32, 32 },
  };


  I guess you  got  what  I  mean:  just  extract  the  configuration
  information  from  the generic source files and create a set of BSP
  specific configuration files.
  
  Two more ideas:
  
  If needed, these config structs could contain pointers  to  special
  functions   initialize,   enable,   disable,   and  shut  down  the
  corresponding ports (in case it's too difficult to come up  with  a
  generic port pin initializaton).

  I have a board in mind with one MPC860 and 3 additional MC68360 (in
  slave mode to add more I/O channels).  This  needs  some  generali-
  zation for the header files, but I have done this befor for another
  RTOS  and maybe I would like to do this for Linux. too. And I guess
  it won't take very long before we have the first boards  with  more
  than  one  82xx.  So maybe we could/should add another parameter to
  these initializatin struct specifying which CPU this port is on?



Ok, this was just a rough  draft  without  much  thinking  about  the
details - any comments?

Wolfgang

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
panic: can't find /

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
