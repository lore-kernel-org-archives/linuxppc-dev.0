From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14760.58981.931858.747899@argo.linuxcare.com.au>
Date: Sun, 27 Aug 2000 20:59:01 +1100 (EST)
To: Martin Costabel <costabel@wanadoo.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Patches for 2.4.0-test7
In-Reply-To: <39A7C246.7BB137EB@wanadoo.fr>
References: <39A7C246.7BB137EB@wanadoo.fr>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Martin Costabel writes:

> - Paul's pmac-devel kernel still eats the LD_LIBRARY_PATH environment
> variable, therefore stopping Mozilla from running. This is so weird (but
> consistent since several months) that I have not the faintest idea where
> it could come from. It is a feature of linux-pmac-devel, not present in
> linux-bk-devel.

Found this one. :-)  Thanks for alerting me to it.  This was because I
have some mods in my tree to add extra aux table entries for the ppc
cache line size.  I was using the numbers assigned in the Sys V ABI
but these conflict with numbers assigned to other things by linux.
The end result was that ld.so always thought it was loading a setuid
program and therefore disabled LD_LIBRARY_PATH.  It's now fixed in my
rsync tree.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
