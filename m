Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18371.41934.106111.627351@cargo.ozlabs.ibm.com>
Date: Tue, 26 Feb 2008 16:29:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: maynardj@us.ibm.com
Subject: Re: copy_from_user problem
In-Reply-To: <47C36FBA.1030600@us.ibm.com>
References: <47C36FBA.1030600@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Maynard Johnson writes:

> I'm developing a kernel module that needs to parse the in-memory ELF 
> objects for a shared library (libc, to be specific).  When running my 
> test on a 32-bit library, it works fine, but for a 64-bit library, the 
> very first copy_from_user() fails:
>     Elf64_Ehdr ehdr;
>     copy_from_user(&ehdr, location_of_lib, sizeof(Elf64_Ehdr);

Should be OK provided location_of_lib is a user address.  I assume you
know that copy_from_user returns the number of bytes *not* copied,
hence a 0 return means success.

> I talked this over a bit with Will Schmidt.  He determined that 
> access_ok (being done as a result of copy_from_user) was failing, but we 

I suggest you print out the value of location_of_lib just to
sanity-check it.

Paul.
