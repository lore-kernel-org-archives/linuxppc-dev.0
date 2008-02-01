Return-Path: <st12@inf.tu-dresden.de>
Received: from mail.inf.tu-dresden.de (mail.inf.tu-dresden.de [141.76.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.inf.tu-dresden.de",
	Issuer "orion.inf.tu-dresden.de" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 47992DDF7A
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 01:56:49 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.inf.tu-dresden.de (8.14.2/8.14.2) with ESMTP id m11EuhMc020120
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Feb 2008 15:56:43 +0100 (CET)
Received: from mail.inf.tu-dresden.de ([127.0.0.1])
	by localhost (mail.inf.tu-dresden.de [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP id aD7qmX4tGDFQ for <linuxppc-dev@ozlabs.org>;
	Fri,  1 Feb 2008 15:56:42 +0100 (CET)
Received: from iai8236 (iai8236.inf.tu-dresden.de [141.76.82.36])
	by mail.inf.tu-dresden.de (8.14.2/8.14.2) with ESMTP id m11EueLr020087
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Feb 2008 15:56:40 +0100 (CET)
From: "Sebastian Theiss" <st12@inf.tu-dresden.de>
To: <linuxppc-dev@ozlabs.org>
References: <002c01c864d0$a4ad11c0$0101a8c0@tis>
Subject: pthread / TQM5200 problem
Date: Fri, 1 Feb 2008 15:56:39 +0100
Message-ID: <003c01c864e2$a6b44e40$0101a8c0@tis>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <002c01c864d0$a4ad11c0$0101a8c0@tis>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Here's some additional information I forgot when originally posting my
question today morning: I'm using the DENX ELDK 3.1.1 and a kernel =
version
2.4.25.

Regards,
Sebastian

-----Urspr=FCngliche Nachricht-----
Von: linuxppc-dev-bounces+st12=3Dinf.tu-dresden.de@ozlabs.org
[mailto:linuxppc-dev-bounces+st12=3Dinf.tu-dresden.de@ozlabs.org] Im =
Auftrag
von Sebastian Theiss
Gesendet: Freitag, 1. Februar 2008 13:48
An: linuxppc-dev@ozlabs.org
Betreff: pthread / TQM5200 problem

Hi all.

I've been having some headache using the pthread library with a TB5200 =
box
(based on a TQM5200 board with a Freescale MPC5200 PowerPC-CPU). I =
created a
small program to pin down the problem and it runs fine on all my Unix- =
and
Linux-machines but fails on the embedded box: The program contains a =
class
CSignal that provides thread-synchronisation based on the
pthread_cond_signal and pthread_cond_wait calls and takes care of the
"spurious wakeup" and "lost signal" problems. The program runs 159
additional threads (that seems to be some internal limit), each of them
continuously increments a field variable and afterwards sleeps until the
main thread wakes it up again. The main thread monitors the whole field =
of
variables that are incremented by the 159 other threads and continuously
wakes them up. When running in the desired way, the program should show =
a
table with 160 entries and each entry (except for the last) should
continuously increase. However, on the box the threads 31 to 64 never =
wake
up, once they call pthread_cond_wait. The code below lacks some error
checking to keep it short, but besides that I don't see what's going =
wrong.
And, the code runs fine on my "real" Linux machines.

Any ideas of what the problem might be and how to fix it? Your I help =
would
be greatly appreciated as I'm rather despaired right now.

Regards,
Sebastian


#include <stdio.h>
#include <pthread.h>

class CSignal
{
public:
	CSignal()
	{
		m_bFlag =3D false;
		pthread_mutex_init(&m_Mutex, NULL);
		pthread_cond_init(&m_Condition, NULL);
	}

	~CSignal()
	{
		pthread_mutex_destroy(&m_Mutex);
		pthread_cond_destroy(&m_Condition);
	}

public:
	void Set(bool bValue =3D true)
	{
		pthread_mutex_lock(&m_Mutex);
		if( m_bFlag =3D bValue ) pthread_cond_broadcast(&m_Condition);
		pthread_mutex_unlock(&m_Mutex);
	}

	void Wait()
	{
		pthread_mutex_lock(&m_Mutex);
		while( !m_bFlag ) pthread_cond_wait(&m_Condition,&m_Mutex);
		pthread_mutex_unlock(&m_Mutex);
	}

protected:
	volatile bool m_bFlag;
	pthread_mutex_t m_Mutex;
	pthread_cond_t m_Condition;
};

#define THREAD_COUNT 160
unsigned char state[THREAD_COUNT];
CSignal signal[THREAD_COUNT];

void* threadproc(void* pParam)
{
	int index =3D (int)pParam;

	while( true )
	{
		state[index]++;
		// wait for the signal beeing set
		signal[index].Wait();
		// reset signal, so that next Wait() will actually case the
thread to sleep again
		signal[index].Set(false);
	}
}

int main()
{
	// clear state field
	for( int i =3D 0; i < THREAD_COUNT; i++ )
	{
		state[i] =3D 0;
	}

	// run 160 threads (creation of the last thread throws EAGAIN, so
159 (+ the main thread)=20
	// seems to be some kind of limit, but that's not the point here)
	for( int i =3D 0; i < THREAD_COUNT; i++ )
	{
		pthread_t id;
		printf("create thread %i: %i\n", i, pthread_create(&id,
NULL, threadproc, (void*)i));
	}

	for(;;)
	{
		// wake all threads
		for( int i =3D 0; i < THREAD_COUNT; i++ )
		{
			signal[i].Set();
		}

		// print state of each thread
		printf("\033[H");
		int thread =3D 0;
		for( int i =3D 0; i < 16; i++ )
		{
			for( int j =3D 0; j < 10; j++, thread++ )
			{
				printf("%03i/%03i ", thread, state[thread]);
			}
			printf("\n");
		}
	}

	return 0;
} =20

=20
_________________________________________________________

 Technische Universit=E4t Dresden
 Fakult=E4t Informatik
 Institut f=FCr Angewandte Informatik
 Lehrstuhl f=FCr Technische Informationssysteme
 D-01062 Dresden

 Besucheradresse: N=F6thnitzer Str. 46, Zi. 1079

 Telefon +49 351 463-38399
 Telefax +49 351 463-38460
 st12@inf.tu-dresden.de
_________________________________________________________
 =20



_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-dev
