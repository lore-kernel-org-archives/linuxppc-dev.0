Message-ID: <39ED3EF5.FF4D52E6@mvista.com>
Date: Wed, 18 Oct 2000 02:11:01 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: paulus@linuxcare.com.au
CC: Tilmann Bitterberg <tibit-ibm@bitterberg.de>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: HIGHMEM now working
References: <Pine.LNX.4.21.0010161220230.1783-200000@karl.rchland.ibm.com>
		<14827.56089.260884.298273@argo.linuxcare.com.au>
		<39EBE0E7.B9313EEE@mvista.com> <14829.14063.44449.96097@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:

> What do you have to initialize that can't wait until m8xx_setup_arch?

I set up the 8xx/82xx CPM.  I can cheat here and grab some physical
pages of memory before the VM grabs them and makes me jump through
hoops to get pages I can just __pa() or __va() :-).  I could probably
move this to later.  I also use a #define IMMR for a pointer to the
internal space of the processor.  Saves a few cycles, but I should
really make this a variable.  I can use the #define because I know
the VM mapping is going to be 1:1.

It's nothing I can't change......


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
